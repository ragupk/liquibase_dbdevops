  /*
  node {
   //sh "cd C://Program Files (x86)//Jenkins//workspace"
   sh "liquibase --changeLogFile=sample.changelog.sql --username=admin --password=oDnIIZHz9VCcDjfi9JOm --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update"
}
*/
// Define variable

//git push -f --tags git@github.com:hari1892/liquibase_dbdevops.git
final TAG = env.TAG
final MYSQL_HOST = env.ENVIRONMENT == 'stage' ? 'liquibaseqa.c8n59c8tfijh.us-east-1.rds.amazonaws.com' : (env.ENVIRONMENT == 'prod' ? 'liquibaseprod.c8n59c8tfijh.us-east-1.rds.amazonaws.com' : 'liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com')
final DB_NAME = env.ENVIRONMENT == 'stage' ? 'liquibaseqa' : (env.ENVIRONMENT == 'prod' ? 'liquibaseprod' : 'liquibasedev')
def AllConfig = [   
  
    "PROD_DB": "",
    "STAGE_DB": "",
    "DEV_DB": "liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com",
    "UPDATE_FILE": "upgrade.sh",
    "ROLLBACK_FILE": "rollback.sh",
    "UPDATE_DIR": "update",
    "ROLLBACK_DIR": "rollback",
 //   "DB_NAME": "liquibasedev",
    "GIT_REPO": "git@github.com:hari1892/liquibase_dbdevops.git",
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
                println(TAG)
		script {
			  if(TAG) {
			deleteDir()	
			sh """
			git clone -b ${TAG} --single-branch ${AllConfig['GIT_REPO']}
			#git clone ${AllConfig['GIT_REPO']} -b ${AllConfig['GIT_BRANCH']} ${TAG}
			dir_name=`ls`
			mv \$dir_name/* .
			rm -rf \$dirname
			pwd
			"""		
			  }
			}
	  println(AllConfig)

          sh "echo ${AllConfig['DEV_DB']}"
		sh """
		ls  ${WORKSPACE}/${AllConfig['UPDATE_DIR']}
		ls ${WORKSPACE}/${AllConfig['ROLLBACK_DIR']}
		ls ${WORKSPACE}/${AllConfig['UPDATE_FILE']}
		ls ${WORKSPACE}/${AllConfig['ROLLBACK_FILE']}
		"""
	withCredentials([usernamePassword(credentialsId: "jenkins_api_token", usernameVariable: 'JENKINS_USERNAME', passwordVariable: 'JENKINS_PASSWORD')]) {
		withCredentials([usernamePassword(credentialsId: "LIQUIBASE_${env.ENVIRONMENT}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {	
	withEnv([    
    "UPDATE_FILE=${WORKSPACE}/${AllConfig['UPDATE_FILE']}",
    "ROLLBACK_FILE=${WORKSPACE}/${AllConfig['ROLLBACK_FILE']}",    
    "UPDATE_DIR=${WORKSPACE}/${AllConfig['UPDATE_DIR']}",
    "ROLLBACK_DIR=${WORKSPACE}/${AllConfig['ROLLBACK_DIR']}",
    "MYSQLHOST=${MYSQL_HOST}",
    "MYSQLUSER=${env.USERNAME}", 
    "MYSQLPASS=${env.PASSWORD}",
    "JENKINS_USER=${env.JENKINS_USERNAME}",
    "JENKINS_PASSWORD=${env.JENKINS_PASSWORD}",
    "BUILD_URL=${BUILD_URL}",
    "GIT_REPO=${AllConfig['GIT_REPO']}",
    "GIT_BRANCH=${AllConfig['GIT_BRANCH']}",
    "DBNAME=${DB_NAME}"]) {
		
      sh 'sh upgrade.sh'
       deleteDir()
       
	 script {
		 if (env.ENVIRONMENT == 'dev') {
       sh """
          if [ ! -z "$GIT_REPO" ]; 
          then git config --global user.email "hari1892@gmail.com" && git config --global user.name "hari1892" && git clone --depth 1 --branch "$GIT_BRANCH" "$GIT_REPO" tag && { cd tag || exit 1 ; } && 
          echo "Tagging git commit $env.BUILD_NUMBER with current build" && 
          { git tag -a -f "$env.BUILD_NUMBER" $GIT_BRANCH -m "Built from $GIT_BRANCH" && 
          git push -f --tags $GIT_REPO ; { cd .. || exit 1 ; } && 
          rm -rf tag ; } 
          fi
          """	
		 }
	 } 
		
	     }
	}
}
	
		
	
		
		
	//  sh 'exit 1'
		
       /*   withCredentials([usernamePassword(credentialsId: "LIQUIBASE", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh 'echo $USERNAME $PASSWORD'
            sh """
            liquibase --changeLogFile=sample.changelog.sql --username=$USERNAME --password=$PASSWORD --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update && \
            echo "\033[42m Liquibase Execution Suceess \033[0m" 
            """
          } */
        }
        }
    }
}
  
