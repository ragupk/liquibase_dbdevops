  /*
  node {
   //sh "cd C://Program Files (x86)//Jenkins//workspace"
   sh "liquibase --changeLogFile=sample.changelog.sql --username=admin --password=oDnIIZHz9VCcDjfi9JOm --classpath=/opt/liquibase/mysql-connector-java-5.1.49-bin.jar --url=jdbc:mysql://liquibasedev.c8n59c8tfijh.us-east-1.rds.amazonaws.com:3306/liquibasedev update"
}
*/
pipeline {
    options {
    ansiColor('xterm')
  }
agent { label 'master' }
    stages {
        stage('Checkout') {
        steps {
          checkout([$class: 'GitSCM', branches: [[name: '*/patch-1']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hari1892/liquibase_dbdevops.git']]])
          sh 'echo hi'
        }
        }
    }
}
  
