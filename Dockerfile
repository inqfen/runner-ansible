FROM alpine:3.9

LABEL maintainer=inqfen@gmail.com

# Install build dependencies
RUN apk update &&\
    apk --no-cache add --virtual build-dependencies \
    unzip \
    build-base \
    libffi-dev \
    python3-dev \
    postgresql-dev \
    postgresql-client libpq \
    openssl-dev &&\
# Install packages
    apk add git curl python3 openssh-client sshpass &&\
# Install terraform
    wget https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip &&\
    unzip terraform_0.12.7_linux_amd64.zip &&\
    mv -f terraform /usr/bin/terraform &&\
# Install python packages
    pip3 install -U pip &&\
    pip3 install ansible==2.8.4 openshift pycrypto docker psycopg2 boto3 pymongo mitogen==0.2.8 &&\
# Remove unusable stuff
    apk del build-dependencies &&\
    rm -rf /var/cache/apk/* &&\
# Change key checking restrictions
    sed -i 's|#   StrictHostKeyChecking ask|StrictHostKeyChecking no|' /etc/ssh/ssh_config

CMD ["echo", "This is image for runner, with ansible, k8s instruments and psycopg2"]
