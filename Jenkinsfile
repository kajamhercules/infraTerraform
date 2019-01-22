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
        container('terraform') {
           sh 'terraform init'
           sh 'terraform plan -out myplan'
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
    stage('Apply') {
      steps {
        container('terraform') {
          sh terraform apply -input=false myplan'
        }
      }
    }
  }
}
