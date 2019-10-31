pipeline {
    agent any
    tools {
        maven 'maven_3.5.3'
    }
    environment {
        IS_SNAPSHOT = readMavenPom().getVersion().endsWith("-SNAPSHOT")
    }
    stages {
        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }
        stage('Deploy to test') {
            environment {
                ADMIN_PASSWORD = credentials('TEST_ADMIN_PASSWORD')
            }
            steps {
                sh './src/main/scripts/deployToTest.sh up'
                sh './src/main/scripts/waitForEnvironment.sh test'
            }
        }
        stage('Server test') {
            steps {
                sh 'mvn verify'
            }
        }
        stage('Stop test environment') {
            steps {
                sh './src/main/scripts/deployToTest.sh stop'
            }
        }
        stage('Deploy to Staging') {
            environment {
                ADMIN_PASSWORD = credentials('STAGING_ADMIN_PASSWORD')
            }
            steps {
                sh './src/main/scripts/deployToStaging.sh up'
                sh './src/main/scripts/waitForEnvironment.sh staging'
            }
        }
        stage('Deploy to Production') {
            when {
                expression {
                    def server_version = "curl -v http://server:9311/version".execute().text
                    println server_version
                    def frontend_version = "curl -v http://server:9310/version".execute().text
                    println frontend_version

                    if ( !server_version.contains('SNAPSHOT') &&
                         !frontend_version.contains('SNAPSHOT') ) {
                        return 1
                    }
                    println "Either the server or the frontend is a SNAPSHOT version and cannot be deployed to Production."
                    return 0
                }
            }
            environment {
                ADMIN_PASSWORD = credentials('PRODUCTION_ADMIN_PASSWORD')
            }
            steps {
                script {
                    echo "This is not a Snapshot version"
                    input "Deploy to prod?"
                    sh './src/main/scripts/deployToProduction.sh up'
                }
            }
        }
    }
}