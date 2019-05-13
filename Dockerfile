FROM ubuntu:xenial

# NOTE: node js version should be a whole number and not a decimal
# https://github.com/nodesource/distributions
ARG NODEJS_VERSION="8"

# OR "latest"
ARG CORDOVA_VERSION="latest"
ARG IONIC_VERSION="latest"


# https://developer.android.com/studio/index.html#command-tools
ARG ANDROID_SDK_VERSION="3859397"
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_BUILD_TOOLS_VERSION="26.0.0"

ENV ANDROID_HOME "${ANDROID_HOME}"

RUN apt-get update
RUN apt-get install -y \
       build-essential \
       openjdk-8-jre \
       openjdk-8-jdk \
       curl \
       unzip \
       git \
       gradle 
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - 
RUN apt-get update 
RUN apt-get install -y nodejs 
RUN npm install -g cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION} 
RUN cd /tmp 
RUN curl -fSLk https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o sdk-tools-linux-${ANDROID_SDK_VERSION}.zip 
RUN unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip 
RUN mkdir /opt/android-sdk 
RUN mv tools /opt/android-sdk 
RUN (while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/bin/sdkmanager --licenses 
RUN $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" 
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" 
RUN apt-get autoremove -y
RUN rm -rf /tmp/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip 
RUN mkdir /ionicapp

WORKDIR /ionicapp
