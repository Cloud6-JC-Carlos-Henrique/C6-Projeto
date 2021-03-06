pipeline {
    agent any
    parameters {
        string(name: 'JAR_NAME', defaultValue:'calculadora', description:'Name of the .jar file')
    }
        
    stages{
          
        stage("Build Jar"){
            steps{
                sh 'javac *.java'
                sh 'jar cfe "$JAR_NAME".jar Calculator *.class'
            }
        }

        stage("Store Artifact on Nexus") {
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'admin', variable: 'USERPASS')]) {
                sh 'curl -v -u "$USERPASS" --upload-file /var/jenkins_home/workspace/C6-Projeto/"$JAR_NAME".jar http://localhost:8081/repository/C6-Projeto/'
                }
            }
        }

        stage('Clear WorkSpace') {
            steps {
                cleanWs()
            }
        }
    } 
}
