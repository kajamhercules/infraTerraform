pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
   stage('TF plan') {
      steps {
        //azureCLI commands: [[exportVariablesString: '', script: 'az login']], principalCredentialId: 'infra'
            sh '''
           az login --service-principal -u a14f94ef-6c2a-4a1f-a7cc-ea23ad338c87 -p infra --tenant bd8ab44a-b4f0-4055-b414-10d1a87c1666
           sudo terraform init
           sudo terraform plan
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
          sudo terraform apply -input=false myplan
          '''
        
      }
    }
  }  
}
