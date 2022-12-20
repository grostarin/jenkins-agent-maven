FROM jenkins/ssh-agent:alpine-jdk17

ENV MAVEN_HOME=/usr/share/maven-3.8
ENV PATH=$PATH:$MAVEN_HOME/bin

#####################################
# install packages
RUN apk update && \ 
    apk add --no-cache git curl && \
    rm -rf /var/cache/apk/*

#####################################
# Add maven 3.5.3
RUN mkdir -p $MAVEN_HOME \
   && curl -kfsSL -o /tmp/maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz \
   && tar -xzf /tmp/maven.tar.gz -C $MAVEN_HOME --strip-components=1 \
   && rm -f /tmp/maven.tar.gz  \
   && rm -f $MAVEN_HOME/conf/settings.xml

# Maven configuration
COPY config/settings.xml $MAVEN_HOME/conf/settings.xml

#####################################
# Check binaries installation
RUN java -version
RUN mvn -version
RUN env

