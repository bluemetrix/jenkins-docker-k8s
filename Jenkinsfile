pipeline {
   agent  any
   environment {
       DOCKER_TAG = getDockerTag()
    }
    stages{

            stage('Build Docker Image'){
                    steps{
                           sh "sudo  docker build  .  -t  onyilimba/nodeapp:${DOCKER_TAG}"
                    }
             }
             stage('DockerHub Push'){
                     steps{
                           withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'dockerHubPwd')]){
                                 sh "docker login -u onyilimba -p ${dockerHubPwd}"
                                 sh "docker push docker.io/onyilimba/nodeapp:${DOCKER_TAG}"
                                 }
                           }
             }
             stage('Deploy to eks'){
                    steps{
                            sh  "chmod  +x  changeTag.sh"
                            sh  "./changeTag.sh  ${DOCKER_TAG}"
                            sshagent(['eks-machine']){
                                sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml  devops@10.0.37.55:/home/ansadmin/"
                              script{
                                      try{
                                            sh "ssh  ansadmin@10.0.37.55 kubectl apply -f ."
                                          }catch(error){
                                            sh "ssh  ansadmin@10.0.37.55  kubectl create -f ."
                                          }
                              }
                            }
                    }
             }
      }
}

def  getDockerTag() {
  def tag = sh  script: 'git rev-parse HEAD', returnStdout: true
  return  tag
}

