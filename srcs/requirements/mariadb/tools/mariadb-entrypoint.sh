#!/bin/bash
set -e

# On the first container run, configure the server to be reachable by other containers
if [ ! -e /etc/.firstrun ]; then
    # Debian stores server-specific configs here
    cat << EOF >> /etc/mysql/mariadb.conf.d/50-server.cnf

[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF
    touch /etc/.firstrun
fi

# On the first volume mount, create a database in it
if [ ! -e /var/lib/mysql/.firstmount ]; then
    # Initialize a database on the volume and start MariaDB in the background
    mariadb-install-db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql >/dev/null 2>/dev/null
    
    mysqld_safe &
    mysqld_pid=$!

    # Wait for the server to be started, then set up database and accounts
    mysqladmin ping -u root --silent --wait >/dev/null 2>/dev/null
    
    # Executing via local socket connection
    cat << EOF | mysql --protocol=socket -u root
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Shut down the temporary server and mark the volume as initialized
    mysqladmin shutdown
    touch /var/lib/mysql/.firstmount
fi

exec mysqld_safe
