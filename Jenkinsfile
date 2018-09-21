pipeline {
   agent any
    stages {
       stage('Build') {
            steps {
                sh 'mvn clean package'
                sh 'echo clean package realizado'
            }
        }
        stage('build') {
            steps {
                sh 'docker build --tag projetodluisb .'
                sh 'echo build realizado'
            }
        }
       stage('subir container') {
         steps {
             sh 'docker run -d --name teste -p 85:8080 projetodluisb'
         }
        }
        stage ('subindo para o dockerhub') {
            steps {
                sh 'echo subindo para o dockerhub'
                sh 'docker tag projetodluisb dluisb/projetodluisb'
                sh 'docker login'
                sh 'docker push dluisb/projetodluisb'
            }
        }
     }
}
