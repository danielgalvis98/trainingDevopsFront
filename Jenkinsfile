node {
  string nodeBaseImage = 'node:16.15.0'

  properties([
    buildDiscarder(logRotator(artifactDaysToKeepStr: '',
      artifactNumToKeepStr: '',
      daysToKeepStr: '100',
      numToKeepStr: '60')),
    disableConcurrentBuilds()
  ])

  stage('Checkout') {
    timeout(3) {
      echo 'Checking out...'
      checkout scm
    }
  }

  stage('Install') {
    timeout(10) {
      echo 'Installing Dependencies...'
      docker.image(nodeBaseImage).inside {
        sh 'npm ci'
      }
    }
  }

  stage('Tests') {
    timeout(10) {
      echo 'Running tests...'
      docker.image(nodeBaseImage).inside {
        sh 'npm run test'
      }
    }
  }

  stage('Clean Workspace') {
    timeout(3) {
      echo 'Cleaning workspace...'
      cleanWs()
    }
  }
}
