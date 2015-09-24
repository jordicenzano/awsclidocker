# awsclidocker
Docker container that contains AWS cli tools

Just run this container with the following shared variables: `SECRETS_S3_REMOTE_PATH`, `SECRETS_LOCAL_PATH`, `S3_REGION`

The file `SECRETS_S3_REMOTE_PATH` will be pulled from S3 to `SECRETS_LOCAL_PATH` using the IAM role assigned to the EC2 box where the container it is running.

Using a shared volume this information can be shared with all containers that runs in the same box

#### Example

```
docker run -e "SECRETS_S3_REMOTE_PATH=alive-secrets/smoketest/secret.txt" -e "SECRETS_LOCAL_PATH=/home/core/secret.txt" -e "S3_REGION=us-west-2" --name='pullSecretsTets' --rm -it jcenzano/awsclidocker
```
