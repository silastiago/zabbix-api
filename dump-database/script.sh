#!/bin/bash

MYSQL_USER="root"
MYSQL_PASS="password here"
MYSQL_DB="zabbix"
LOG="/backups/resultado_backup.log"
DIR_BACKUP="/backups/zabbix"
DATA=$(date +%d-%m-%Y)


mysqldump --single-transaction -u$MYSQL_USER -p$MYSQL_PASS --comments --log-error=$LOG --databases $MYSQL_DB | gzip > $DIR_BACKUP/$DATA.sql.gz


