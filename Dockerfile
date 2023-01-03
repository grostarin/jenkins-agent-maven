FROM jenkins/ssh-agent:alpine-jdk17

ENV MAVEN_HOME=/usr/share/maven-3.8
ENV PATH=$PATH:$MAVEN_HOME/bin
ARG BIN_PATH=/usr/local/sbin

#####################################
# install packages
RUN apk update && \ 
    apk add --no-cache git curl buildah && \
    rm -rf /var/cache/apk/*

#####################################
# Add maven 3.5.3
RUN mkdir -p $MAVEN_HOME \
   && curl -kfsSL -o /tmp/maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz \
   && tar -xzf /tmp/maven.tar.gz -C $MAVEN_HOME --strip-components=1 \
   && rm -f /tmp/maven.tar.gz  \
   && rm -f $MAVEN_HOME/conf/settings.xml \
   && mkdir -p $BIN_PATH \
   && ln -s $MAVEN_HOME/bin/mvn $BIN_PATH/mvn

# Maven configuration
COPY config/settings.xml $MAVEN_HOME/conf/settings.xml

# Add data for buildah
RUN echo jenkins:10000:65536 >> /etc/subuid && \
    echo jenkins:10000:65536 >> /etc/subgid

#####################################
# Check binaries installation
RUN java -version
RUN mvn -version
RUN buildah --version
RUN env
