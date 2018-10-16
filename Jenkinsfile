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
   
   stage('Publish') {
      steps{
     nexusPublisher nexusInstanceId: 'localNexus2', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/Nova-pipeline/target/Proxy_Default-0.0.1.jar']], mavenCoordinate: [artifactId: 'Proxy_Default', groupId: 'com.indra.desafio', packaging: 'jar', version: '0.0.1']]]
                    }
              }
      }
}
