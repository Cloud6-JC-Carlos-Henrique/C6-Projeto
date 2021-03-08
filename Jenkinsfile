pipeline {
    agent any
    parameters {
        string(name: 'JAR_NAME', defaultValue:'calculadora', description:'Name of the .jar file')
        string(name: 'DOCKER_IMAGE_NAME', defaultValue:'java-calculator', description:'Name of the Image')
    }
        
    stages{
          
        stage("Build Jar"){
            steps{
                sh 'javac *.java'
                sh 'jar cfe "$JAR_NAME".jar Calculator *.class'
            }
        }

        stage ('SonarQube analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonarqube';
                    withSonarQubeEnv ('sonarqubec6') {
                        sh "${scannerHome}/bin/sonar-scanner \
                        -D sonar.login=dff2aee92477026e5d15525736d876474060a670 \
                        -D sonar.projectKey=C6-Projeto \
                        -D sonar.java.binaries=/var/jenkins_home/workspace/C6-Projeto \
                        -D sonar.java.source=11 \
                        -D sonar.host.url=http://sonarqube:9000"
                    }
                }
            }
        }
        
        stage("Store Artifact on Nexus") {
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'admin', variable: 'USERPASS')]) {
                sh 'curl -v -u "$USERPASS" --upload-file /var/jenkins_home/workspace/C6-Projeto/"$JAR_NAME".jar http://nexus:8081/repository/C6-Projeto/'
                }
            }
        }

        stage('Create Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE_NAME}:${VERSION} ."
            }
        }

        stage('Push Image to Nexus') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'admin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh 'docker login -u "$USERNAME" -p "$PASSWORD" nexus:8082'
                sh "docker tag ${DOCKER_IMAGE_NAME}:${VERSION} nexus:8082/${DOCKER_IMAGE_NAME}:${VERSION}"
                sh "docker push nexus:8082/${DOCKER_IMAGE_NAME}:${VERSION}"
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
