pipeline {
   agent any
   stages {
      stage('Build') {
          steps { 
                sh 'mvn clean package'
                sh 'echo clean package realizado'
                clean verify sonar:sonar -Ptestes-integracao 
                -Dphantomjs.binary.path=$PHANTOMJS_DIR/bin/phantomjs
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
