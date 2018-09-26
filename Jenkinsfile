pipeline {
   agent any
   stages {
      stage('Build') {
          steps { 
                sh 'mvn sonar:sonar -Dsonar.host.url=http://192.168.56.102:9000 -Dsonar.login=f46f00ea7c997c06f352622ade5efb21a255a441'
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
