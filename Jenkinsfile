
pipeline {
    agent none 
    parameters {
        string(name: 'S3', defaultValue: 'super-original-name-for-task-bucket-1-upload')
        string(name: 'datefilename', defaultValue: 'datefile', description: 'this is the name of the file created by date.sh')
        booleanParam(name: 'isForUpload', defaultValue: true, description: 'to upload or not to upload...')
    }
    stages {
        stage('Executing shell script') {
            agent { label 'ja2' } 
            steps {
                deleteDir()
                echo '...cloning GIT repository'
                git 'https://github.com/irynadiudiuk/Dev_Ops_Mentorship_Program.git'
                sh './date.sh' 
                  }
        }
        stage('S3 upload') {
            agent { label 'ja2' } 
            steps {
                print 'DEBUG: parameter isForUpload = ' + params.isForUpload
                print "DEBUG: parameter isForUpload = ${params.isForUpload}"
                sh "echo sh isForUpload is ${params.isForUpload}"
                  }
                when {
                // Only upload when isForUpload is true
                expression { return token ==~ /(?i)(Y|YES|T|TRUE|ON|RUN)/ }
            }
                echo '...we are uploading file to S3'
                s3Upload acl: 'Private', bucket: 'super-original-name-for-task-bucket-1-upload', cacheControl: '', excludePathPattern: '', file: "${params.datefilename}", path: '.', metadatas: [''], sseAlgorithm: '', workingDir: ''
                deleteDir()
                emailext body: 'This is a test mail', subject: 'This is a test mail', to: 'is31214@gmail.com'
            }
        }
    }
}
