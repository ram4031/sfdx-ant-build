# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:14.14-alpine

#add usefull tools
RUN apk add --update --no-cache  \
  git \
  findutils \
  bash \
  unzip \
  curl \
  wget \
  nodejs-npm \
  openjdk8-jre \
  openssh-client \
  openssl\
  perl \
  jq \
  apache-ant --update-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
  --allow-untrusted

# install Salesforce CLI from npm
RUN npm install sfdx-cli --global
RUN sfdx --version

# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
RUN echo y | sfdx plugins:install sfdx-git-delta
RUN sfdx plugins

# legacy way to install SFDX-Git-Delta, if you still want to use the sgd command (not needed if you use the Salesforce CLI extension)
RUN npm install sfdx-git-delta@latest --global
RUN sgd --version

ENV ANT_HOME /usr/share/java/apache-ant
ENV PATH $PATH:$ANT_HOME/bin