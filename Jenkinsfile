pipeline {
   agent any
   stages {
      stage ('Checkout'){
          steps{
            deleteDir()
            checkout scm
         }
      }
     stage('Pacotes') {
          steps { 
                sh 'mvn clean package'
                sh 'mvn sonar:sonar'
                sh 'npm install'
                sh 'mvn clean deploy'
                sh 'echo clean package realizado'
                /* sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.5.0.1254:sonar'*/
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
             script{
               try{
                   sh 'docker run -d --name ghthomazini -p 86:8080 ghthomazini'                   
                 } 
                catch(exc) {
                   sh 'docker stop ghthomazini'
                   sh 'docker rm ghthomazini'
                   sh 'docker run -d --name ghthomazini -p 86:8080 ghthomazini'
                     }
                 }
             }
       }
        stage ('subindo para o dockerhub') {
            steps {
               withCredentials([string(credentialsId: 'senha', variable: 'SENHA') ]) {
                  sh 'echo subindo para o dockerhub'
                  sh 'docker tag ghthomazini ghthomazini/projetodevops'
                  sh 'docker login -u ghthomazini -p $SENHA' 
                  sh 'docker push ghthomazini/projetodevops'
                 
               }
            }
        }
     }
}
