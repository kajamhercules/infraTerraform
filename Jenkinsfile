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
          azureCLI commands: [[exportVariablesString: '', script: 'az login']], principalCredentialId: 'jenkinsuser'
            sh '''
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
          sudo terraform apply -input=false myplan
          '''
        
      }
    }
  }  
}
