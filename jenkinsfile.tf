pipeline {
    agent any
      stages {
         stage('Build') { 
            steps { 
              sh "printenv"
              sh "docker build -t ecr-demoing"
       
            }
        }

        stage('Publish ECR') { 
            steps { 
                withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}","AWS_SECRET_ACCESS_KEY_ID=${env.AWS_SECRET_ACCESS_KEY_ID}","AWS_DEFAULT_REGION=${env.AWS_DEFAULT_REGION}"]) {
                 sh "docker login -u AWS -p$(aws ecr-public get-login-password --region us-east-1) public.ecr.aws/x3l0e3y5"
                  sh "docker build -t ecr-demoing"
       
                }
            }
        }
        
        }
    }
}
