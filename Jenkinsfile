pipeline{
    agent any
    tools {
      maven 'MAVEN_3.3.9'
    }
    environment {
      DOCKER_TAG = getVersion()
    }

    stages {
        
        stage ('Checkout Source') {
            steps {
              git credentialsId: 'bhanumannuru', 
              url: 'https://github.com/bhanumannuru/hello-world.git'
            
            }
        }
        
        stage ('Maven Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage ('Testing Stage') {
            steps {
                sh 'mvn test'
            }
        }

        stage ('Maven Build') {
             steps {
                 sh 'mvn clean package'
            }
        }
        
        stage ('Docker Build') {
            steps{
                sh "docker build . -t bhanumannuru/hello-world:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'Docker_Hub', variable: 'dockerhubpwd')]) {
                    sh "docker login -u bhanumannuru -p ${dockerhubpwd}"
                }
                
                sh "docker push bhanudevops106/hello-world:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'docker_server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
