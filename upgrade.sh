#!/bin/bash

# if any step fails during the rolling update, this will ensure that the script dies immediately
set -x

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

export BUILD_USER=`echo ${jobUserName}  | sed 's/\s/ /g'`


assertExists "$UPDATE_DIR" "Set the file location to update MYSQL."
assertExists "$ROLLBACK_DIR" "Set the file location to rollback MYSQL."
assertExists "$MYSQLHOST" "Set the hostname for mysql"
assertExists "$MYSQLUSER" "Set the username for MYSQL."
assertExists "$MYSQLPASS" "Set the password for MYSQL."
assertExists "$DBNAME" "Set the DBName for MYSQL"
 echo $BUILD_USER


updatescripts=`ls $UPDATE_DIR| wc -l`
rollbackscripts=`ls $ROLLBACK_DIR | wc -l`
	  

#Current Date Function
#changedate= `mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME -e "SELECT CURDATE() ;"`
#echo $changedate


LIST=`exec ls $UPDATE_DIR | sed 's/\([0-9]\+\).*/\1/g' | tr '\n' ' '`
echo $LIST
mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME -e "CREATE TABLE IF NOT EXISTS databasechangelog (
		    id      int             NOT NULL,
		    auth_name  varchar(80)  NOT NULL,
		    changedate datetime     default current_timestamp NOT NULL,
		    PRIMARY KEY (id)                   
		    )"
versionnum=`mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME -e "select ifnull(max(id),0) as id from databasechangelog;"`
currentversion=`echo $versionnum |awk '{print $2}'`
echo $currentversion

#if [ "$updatescripts" == "$rollbackscripts" ]; then
        for number in $LIST
        do
                if [ "$number" -gt "$currentversion" ]; then
		echo "insert into databasechangelog(id,auth_name) values($number,'$BUILD_USER')" >> $UPDATE_DIR/$number.sql
                mysql  -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASS $DBNAME < $UPDATE_DIR/$number.sql
                fi
        done
#else
#echo "The update scripts and the rollback script doesn't match"
#fi
