pipeline {
  agent any
  stages {
    stage('Checkout') {
      parallel {
        stage('Checkout') {
          steps {
            checkout scm
          }
        }
        stage('Test') {
          steps {
            echo 'test'
          }
        }
      }
    }
    stage('TF plan') {
      steps {
        sh '''
         # az login --service-principal -u a14f94ef-6c2a-4a1f-a7cc-ea23ad338c87 -p infra --tenant bd8ab44a-b4f0-4055-b414-10d1a87c1666
           sudo terraform init
           sudo terraform plan -out myplan
        '''
      }
    }
    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?',
          parameters: [ [$class: 'BooleanParameterDefinition',
          defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }

      }
    }
    stage('Apply') {
      steps {
        sh '''
          sudo terraform destroy -auto-approve
          sudo terraform apply -input=false myplan
          '''
      }
    }
  }
}