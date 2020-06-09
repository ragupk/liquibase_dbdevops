
pipeline {
    options {
    ansiColor('xterm')
  }
agent { label 'master' }
    stages {
        stage('Liquibase Execution') {
        steps {
        //  checkout([$class: 'GitSCM', branches: [[name: '*/patch-1']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hari1892/liquibase_dbdevops.git']]])
          withCredentials([usernamePassword(credentialsId: "LIQUIBASE", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh """
            liquibase --changeLogFile=sample.changelog.sql --username=$USERNAME --password=$PASSWORD --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update && \
            echo "\033[1;4;37;42m LiquiBase Execution success \033[0m"
            """
          }
        }
        }
    }
}
  
