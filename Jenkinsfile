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
    "UPDATE_FILE": "upgrade.sh",
    "ROLLBACK_FILE": "rollback.sh",
    "UPDATE_DIR": "update",
    "ROLLBACK_DIR": "rollback",
    "DB_NAME": "liquibasedev",
    "GIT_BRANCH": "patch-1",
      
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
		sh """
		ls  ${WORKSPACE}/${AllConfig['UPDATE_DIR']}
		ls ${WORKSPACE}/${AllConfig['ROLLBACK_DIR']}
		ls ${WORKSPACE}/${AllConfig['UPDATE_FILE']}
		ls ${WORKSPACE}/${AllConfig['ROLLBACK_FILE']}
		"""
	withCredentials([usernamePassword(credentialsId: "jenkins_api_token", usernameVariable: 'JENKINS_USERNAME', passwordVariable: 'JENKINS_PASSWORD')]) {
	withCredentials([usernamePassword(credentialsId: "LIQUIBASE", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {	
	BUILD_TRIGGER_BY = sh ( script: "BUILD_BY=\$(curl -k --silent ${BUILD_URL}/api/xml | tr '<' '\n' | egrep '^userId>|^userName>' | sed 's/.*>//g' | sed -e '1s/\$/ \\/ /g'); if [[ -z \${BUILD_BY} ]]; then BUILD_BY=\$(curl -k --silent ${BUILD_URL}/api/xml | tr '<' '\n' | grep '^shortDescription>' | sed 's/.*user //g;s/.*by //g'); fi; echo \${BUILD_BY}", returnStdout: true ).trim()
        sh 'echo "BUILD_TRIGGER_BY: ${BUILD_TRIGGER_BY}"'
        sh 'exit 1'
	withEnv([    
    "UPDATE_FILE=${WORKSPACE}/${AllConfig['UPDATE_FILE']}",
    "ROLLBACK_FILE=${WORKSPACE}/${AllConfig['ROLLBACK_FILE']}",    
    "UPDATE_DIR=${WORKSPACE}/${AllConfig['UPDATE_DIR']}",
    "ROLLBACK_DIR=${WORKSPACE}/${AllConfig['ROLLBACK_DIR']}",
    "MYSQLHOST=${AllConfig['DEV_DB']}",
    "MYSQLUSER=${env.USERNAME}", 
    "MYSQLPASS=${env.PASSWORD}",
    "DBNAME=${AllConfig['DB_NAME']}"]) {
		
      sh 'sh upgrade.sh'
	     }
	}
}
		
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
  
