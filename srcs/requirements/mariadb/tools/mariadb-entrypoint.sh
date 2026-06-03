#!/bin/bash
set -e

# Ensure runtime directories exist with proper permissions for the local socket
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# On the first container run, configure the server to be reachable over the network
if [ ! -e /etc/.firstrun ]; then
    # Drop an override file into conf.d instead of modifying 50-server.cnf directly
    cat << EOF > /etc/mysql/conf.d/docker.cnf
[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF
    touch /etc/.firstrun
fi

# On the first volume mount, create a database in it
if [ ! -e /var/lib/mysql/.firstmount ]; then
    echo "Initializing MariaDB database..."
    
    # Force ownership of the volume directory to the mysql user
    chown -R mysql:mysql /var/lib/mysql

    # Initialize data directory layouts
    mariadb-install-db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql >/dev/null 2>/dev/null

    # Start a temporary background instance to inject initial root/user tables
    mysqld_safe --datadir=/var/lib/mysql &
    
    # Wait for the local server to respond to socket pings
    mysqladmin ping -u root --silent --wait >/dev/null 2>/dev/null

    # Inject your environment credentials securely using the local root socket connection
    cat << EOF | mysql --protocol=socket -u root
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Gracefully bring down the temporary background server instance
    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
    
    # Ensure everything created during the init sequence belongs to the mysql engine execution user
    chown -R mysql:mysql /var/lib/mysql
    touch /var/lib/mysql/.firstmount
fi

# Safety check: ensure permissions are fully synced before starting the main process
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB..."
exec mysqld_safe --datadir=/var/lib/mysql
