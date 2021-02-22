pipeline {
    agent any

    stages{
        stage('deploy to S3'){
            steps{
                sh '/usr/local/bin/aws s3 cp index.html s3://krish2424pipeline'
                sh '/usr/local/bin/aws s3api put-object-acl --bucket krish2424pipeline --key index.html --acl public-read'
                sh '/usr/local/bin/aws s3 cp public/error.html s3://krish2424pipeline'
                sh '/usr/local/bin/aws s3api put-object-acl --bucket krish2424pipeline --key error.html --acl public-read'
            }
        }
    }
    post{
        always{
            cleanWs disableDeferredWipeout: true, deleteDirs: true
        }
    }

}
