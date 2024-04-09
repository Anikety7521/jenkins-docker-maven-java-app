pipeline {
    agent {
        label "Docker_slave"
    }
    
    stages{
        stage ("Pull From SCM"){
            steps{
                git branch: 'main', url: 'https://github.com/Anikety7521/jenkins-docker-maven-java-app.git'
            }
        }
        
        stage ("Build Maven pkg"){
            steps{
                sh 'mvn clean package'
                stash name: 'maven-artifacts', includes: 'target/*.war'
                stash name: 'dockerfile', includes: 'Dockerfile'
            }
        }
        
        stage ("Build Docker Image"){
            steps{
                node('slave_1') {
                    unstash 'maven-artifacts'
                    unstash 'dockerfile'
                    //git branch: 'main', url: 'https://github.com/Anikety7521/jenkins-docker-maven-java-app.git'
                    sh 'sudo docker build -t aniket86/maven-jenkins-webapp:${BUILD_TAG} .'
                    
                }
            }
        }
        
        stage ("PUSH Docker Image"){
            agent {
                label "slave_1"
            }
            steps{
                
                    
                    withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWD', variable: 'DOCKER_HUB_PASSWD_VARIABLE')]) {
                        sh 'sudo docker login -u aniket86 -p ${DOCKER_HUB_PASSWD_VARIABLE}'
                    }
                    sh 'sudo docker push aniket86/maven-jenkins-webapp:${BUILD_TAG}'
                    
                
            }
        }
        
        stage ("Deploy on QA Test Env"){
            agent {
                label "slave_1"
            }
            steps{
                    sshagent(['AWS-slave-passwd']) {
                        sh 'ssh -o  StrictHostKeyChecking=no ec2-user@13.233.132.216 sudo docker rm -f webapp'
                        sh 'ssh ec2-user@13.233.132.216 sudo docker run -d  -p 8080:8080 --name webapp aniket86/maven-jenkins-webapp:${BUILD_TAG}'
                    }
                    
                
            }
        }
        
        stage ("QA Test"){
            agent {
                label "slave_1"
            }
            steps{
                    sh 'curl --silent http://13.233.132.216:8080/java-web-app/ | grep Aniket'
            }
        }
        
        stage ("Approve stage"){
            steps{
                input(message:"Release to Production.....? ")
            }
        }
        
        stage ("Deploy Production Env"){
            agent {
                label "slave_1"
            }
            steps{
                    sshagent(['AWS-slave-passwd']) {
                        sh 'ssh -o  StrictHostKeyChecking=no ec2-user@3.110.188.41 sudo docker rm -f webapp'
                        sh 'ssh ec2-user@3.110.188.41 sudo docker run -d  -p 8080:8080 --name webapp aniket86/maven-jenkins-webapp:${BUILD_TAG}'
                    }
                    
                
            }
        }
    }
    
    
    
}