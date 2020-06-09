  /*
  node {
   //sh "cd C://Program Files (x86)//Jenkins//workspace"
   sh "liquibase --changeLogFile=sample.changelog.sql --username=admin --password=oDnIIZHz9VCcDjfi9JOm --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update"
}
*/
// Define variable
def AllConfig = [   
  
		"PROD_DB": "",
    "STAGE_DB": "",
    "DEV_DB": "liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com",
    "UPDATE_FILE": "",
    "ROLLBACK_FILE": "",
    "UPDATE_DIR": "${env.WORKSPACE}/update",
    "ROLLBACK_DIR": "",
    "DB_NAME": "",
      
	     ] 



pipeline {
    options {
    ansiColor('xterm')
  }
agent { label 'master' }
    stages {
        stage('Liquibase') {
        steps {
        //  checkout([$class: 'GitSCM', branches: [[name: '*/patch-1']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hari1892/liquibase_dbdevops.git']]])
          println(AllConfig)
          sh "echo ${AllConfig['DEV_DB']}"
	  sh "echo ${AllConfig['UPDATE_DIR']}"//LIQUIBASE 
	  sh 'exit 1'
          withCredentials([usernamePassword(credentialsId: "LIQUIBASE", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh 'echo $USERNAME $PASSWORD'
            sh """
            liquibase --changeLogFile=sample.changelog.sql --username=$USERNAME --password=$PASSWORD --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update && \
            echo "\033[42m Liquibase Execution Suceess \033[0m" 
            """
          }
        }
        }
    }
}
  
