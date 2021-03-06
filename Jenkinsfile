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

        stage("store artifact on Nexus") {
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'admin', variable: 'USERPASS')]) {
                sh 'curl -v -u "$USERPASS" --upload-file /var/jenkins_home/workspace/Calculadora-Pipeline/"$JAR_NAME".jar http://localhost:8081/repository/my-raw/'
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
