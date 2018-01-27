pipeline {
  agent any
  stages {
    stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      steps {
            // deleteDir()
            // git url: 'https://github.com/chunlinyao/moqui-boot.git'

            // gradle gitPullAll can update, but Jenkins git plugin not
            // aware the url, so commitNotify will not trigger build.
            // use git plugin to update source so it will trigger build.
            dir("moqui/runtime/component/example") {
                git url: 'https://github.com/moqui/example.git'
            }
      }
    }
    stage('Build') {
      // Run the maven build
      steps{
            script {
              if (isUnix()) {
                sh "./gradlew --no-daemon getComponent -Pcomponent=example"
                sh "./gradlew --no-daemon gitPull"
                sh "./gradlew --no-daemon cleanAll"
                sh "./gradlew --no-daemon build"

              }
            }
      }
    }
    stage('Tests') {
      steps {
            sh "./gradlew --no-daemon load"
            sh "./gradlew --no-daemon runtime:component:example:test --info"
      }
      post {
        always{
          // archive 'moqui.war'
          publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'moqui/runtime/component/example/build/reports/tests/test/', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: ''])
          junit keepLongStdio: true, testResults: '**/test-results/**/*.xml'
        }
      }
    }
  }
  post {
    always {
      echo currentBuild.getPreviousBuild().result
      echo currentBuild.result
      script {
        // current is null means still no error
        if (currentBuild.getResult() != null || (currentBuild.getPreviousBuild() &&
                                                 currentBuild.getPreviousBuild().getResult().toString() != "SUCCESS")) {

          emailext subject: '$DEFAULT_SUBJECT',
          body: '$DEFAULT_CONTENT',
          recipientProviders: [
            [$class: 'CulpritsRecipientProvider'],
            [$class: 'DevelopersRecipientProvider'],
            [$class: 'RequesterRecipientProvider']
          ],
          to: '$DEFAULT_RECIPIENTS'
        }
      }
    }
  }
}
