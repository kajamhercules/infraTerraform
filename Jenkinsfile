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
        sh '''sh \'terraform init\'
sh \'terraform plan -out myplan'''
      }
    }
    stage('Approval') {
      steps {
        sh '''def userInput = input(id: \'confirm\', message:
 \'Apply Terraform?\', parameters: 
[ [$class: \'BooleanParameterDefinition\', defaultValue: 
false, description: \'Apply terraform\', name: \'confirm\']
 ])'''
      }
    }
    stage('Apply') {
      steps {
        sh 'sh terraform apply -input=false myplan'
      }
    }
  }
}
