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

  stage('Build and Publish') {
      timeout(10) {
        echo 'Building docker image...'
        def registry = 'registry:5000'
        def serviceName = 'review-ui'
        def branchName = env.CHANGE_BRANCH ?: env.BRANCH_NAME

        def pushImage = docker.build("${registry}/${serviceName}:${branchName}-${BUILD_ID}")
        pushImage.push()

        if (branchName == 'master') {
          pushImage.push('latest')
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
