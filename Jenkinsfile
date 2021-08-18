pipeline {

    agent any

    options { disableConcurrentBuilds() }

    stages {

            stage('Clean Up') {
              steps {
                echo 'Cleaning without ws ...'
                cleanWs()
                }
            }

            stage('Clone Repository') {
                      steps {
                        echo 'Checking out the latest code from Github'
                        checkout scm
                  }
            }

            stage('Package') {
                steps {
                    echo 'Building ...'
                    sh 'mvn clean package'
                }
            }


            stage("Docker Build/Push") {
                steps {
                    echo 'Build for Docker...'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                      sh '''
                      echo "${PROFILE_NAME}"
                      docker login -u "$USERNAME" -p "$PASSWORD"
                      docker build . -t sueda123/k8stest:jenkintest
                      docker push sueda123/k8stest:jenkintest
                      docker logout
                      '''
                    }
                }
            }

            stage('K8s Deploy') {
                steps {
                    echo 'K8s Deploy...'
                    sh '''
                    kubectl apply -f testdeployment.yaml
                    '''
                }
            }
    }

    post {
           failure {
               echo "Deploy Failed"
           }
           success {
               echo "Deploy Successfully Completed..."
           }
       }
}
