# This script pulls a file from S3 using the IAM role assigned to the EC2 where its running.
# With a shared volume this information can be shared with all containers in that box
#
# Uses the following environtment vars:
# SECRETS_S3_REMOTE_PATH="bucket/dir/filename.txt"
# SECRETS_LOCAL_PATH="/data/secrets.sh"
# S3_REGION="us-west-2"

if [ -z "$SECRETS_S3_REMOTE_PATH" ]; then echo "SECRETS_S3_REMOTE_PATH is unset"; fi
if [ -z "$SECRETS_LOCAL_PATH" ]; then echo "SECRETS_LOCAL_PATH is unset"; fi
if [ -z "$S3_REGION" ]; then echo "S3_REGION is unset"; fi

aws --region $S3_REGION s3 cp s3://$SECRETS_S3_REMOTE_PATH $SECRETS_LOCAL_PATH