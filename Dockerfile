FROM alpine:3.9

LABEL maintainer=inqfen@gmail.com

# Install build dependencies
RUN apk update &&\
    apk --no-cache add --virtual build-dependencies \
    build-base \
    libffi-dev \
    python3-dev \
    postgresql-dev \
    postgresql-client libpq \
    openssl-dev &&\
# Install packages
    apk add git curl python3 openssh-client sshpass &&\
# Install python packages
    pip3 install -U pip &&\
    pip3 install ansible==2.8.0 openshift pycrypto docker psycopg2 &&\
# Remove unusable stuff
    apk del build-dependencies &&\
    rm -rf /var/cache/apk/* &&\
# Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl &&\
# Change key checking restrictions
    sed -i 's|#   StrictHostKeyChecking ask|StrictHostKeyChecking no|' /etc/ssh/ssh_config

CMD ["echo", "This is image for runner, with ansible, k8s instruments and psycopg2"]