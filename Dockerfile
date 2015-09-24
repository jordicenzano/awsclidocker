# Generate a docker for live streaming load testing
# by Jordi Cenzano
# VERSION               1.0.1

FROM ubuntu:14.04
MAINTAINER jordi.cenzano@gmail.com

#Update
RUN apt-get update -y && \
apt-get clean

#Upgrade
RUN apt-get upgrade -y && \
apt-get clean

#Install curl
RUN apt-get install curl -y && \
apt-get clean

#Install unzip
RUN apt-get install unzip -y && \
apt-get clean

#Install phyton
RUN apt-get install build-essential checkinstall -y
RUN apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
RUN apt-get clean 
RUN mkdir -p /data/tmp
RUN curl 'https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz' -o /data/tmp/Python-2.7.10.tgz && \
cd /data/tmp && \
tar -xvf Python-2.7.10.tgz && \
cd Python-2.7.10 && \
./configure && \
make && \
checkinstall && \
rm -r /data/tmp

#Install AWS cli
RUN mkdir -p /data/tmp && \
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/data/tmp/awscli-bundle.zip" && \
cd /data/tmp && \
unzip awscli-bundle.zip && \
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
rm -r /data/tmp

#Copy get secrets 
COPY scripts/get_secrets.sh data/scripts/get_secrets.sh
RUN chmod 755 /data/scripts/get_secrets.sh

#Start test
ENTRYPOINT /data/scripts/get_secrets.sh