
pipeline {
    agent none 
    parameters {
        string(name: 'S3', defaultValue: 'super-original-name-for-task-bucket-1-upload')
        string(name: 'datefilename', defaultValue: 'datefile', description: 'this is the name of the file created by date.sh')
    }
    stages {
        stage('Executing shell script') {
            agent { label 'ja2' } 
            steps {
                deleteDir()
                echo '...cloning GIT repository'
                git 'https://github.com/irynadiudiuk/Dev_Ops_Mentorship_Program.git'
                sh './date.sh' 
                sh 'ls -al'
                sh 'export FILE=$(ls file.*)'
                script {
                    FILE = sh (returnStdout: true, script: "ls file.*").trim()
                }
            }
        }
        stage('S3 upload') {
            agent { label 'ja2' } 
            steps {
                echo '...we are uploading file to S3'
                s3Upload acl: 'Private', bucket: 'super-original-name-for-task-bucket-1-upload', cacheControl: '', excludePathPattern: '', file: "${params.datefilename}", path: '.', metadatas: [''], sseAlgorithm: '', workingDir: ''
                deleteDir()
                emailext body: 'This is a test mail', subject: 'This is a test mail', to: 'is31214@gmail.com'
            }
        }
    }
}
