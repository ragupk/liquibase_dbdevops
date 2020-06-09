#!/bin/bash

# if any step fails during the rolling update, this will ensure that the script dies immediately
set -e

# a simple function which checks that an environment variable exists, and fails with a message if it does not
assertExists () {
  if [ -z "$1" ]; then
    echo "$2"
	exit 1
  fi
}

# checks for an optional environment variable and prints the warning if it is missing
assertOptional () {
  if [ -z "$1" ]; then
    echo "$2"
  fi
}

assertExists "$UPDATE_DIR" "Set the file location to update MYSQL."
assertExists "$ROLLBACK_DIR" "Set the file location to rollback MYSQL."
assertExists "$MYSQLHOST" "Set the hostname for mysql"
assertExists "$MYSQLUSER" "Set the username for MYSQL."
assertExists "$MYSQLPASS" "Set the password for MYSQL."
assertExists "$DBNAME" "Set the DBName for MYSQL"
assertExists "$ROLLBACK_VERSION" "Set the rollback version number"

rollback_version=$ROLLBACK_VERSION
echo ROllBACK_TO_VERSION:$rollback_version


LIST=`exec ls $ROLLBACK_DIR | sed 's/\([0-9]\+\).*/\1/g' | tr '\n' ' '`
echo $LIST
versionnum=`mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME -e "select * from version;"`
currentversion=`echo $versionnum |awk '{print $2}'`

for ((i=$currentversion; i>=$rollback_version; i--))
do
mysql  -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME < $ROLLBACK_DIR/$i.sql
done

