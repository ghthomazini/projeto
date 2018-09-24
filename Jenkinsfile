pipeline {
   agent any
   stages {
       stage ('Checkout'){
          steps{
   deleteDir()
  checkout scm
 }
       }
       stage('Build') {
          steps {
                sh 'mvn clean package'
                sh 'echo clean package realizado'
            }
        }
        stage('build') {
            steps {
                sh 'docker build --tag ghthomazini .'
                sh 'echo build realizado'
            }
        }
       stage('subir container') {
         steps {
             sh 'docker stop ghthomazini'
             sh 'docker rm ghthomazini'
             sh 'docker run -d --name ghthomazini -p 86:8080 ghthomazini'
         }
        }
        stage ('subindo para o dockerhub') {
            steps {
               withCredentials([ string(credentialsId: 'senha', variable: 'SENHA') ]) {
                  sh 'echo subindo para o dockerhub'
                  sh 'docker tag ghthomazini ghthomazini/projetodevops'
                  sh 'docker login -u ghthomazini -p $SENHA' 
                  sh 'docker push ghthomazini/projetodevops'
               }
            }
        }
     }
}
