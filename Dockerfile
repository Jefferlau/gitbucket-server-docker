FROM java:8

MAINTAINER Jeffer Lau "jefferlzu@gmail.com"

# Update aptitude with new repo
RUN apt-get update

# Download gitbucket
RUN wget https://github.com/gitbucket/gitbucket/releases/download/4.13/gitbucket.war

# Create Gitbucket data directory by default
RUN mkdir /root/.gitbucket

ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"
ENTRYPOINT [ "sh", "-c", "java -jar gitbucket.war" ]
