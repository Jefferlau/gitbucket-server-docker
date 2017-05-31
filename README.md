# gitbucket-server-docker
Git Server by GitBucket

## 使用 Docker 部署 Git 服务 ([gitbucket](https://github.com/gitbucket/gitbucket/releases))

```bash
# 创建一个容器，用于记录命令，创建 Dockerfile 文件。
docker run -it --name jefferlau-gitbucket-editor -d java:8 /bin/bash
# 连接至容器。
docker exec -it jefferlau-gitbucket-editor /bin/bash
```
编写 Dockerfile 文件。
```dockerfile
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
```
编译 Docker 镜像。
```bash
docker build -t gitbucket-server .

```
推送到 Docker Hub 存储。
[https://docs.docker.com/docker-cloud/builds/push-images/]()
```bash
# tag lastest
docker tag gitbucket-server jefferlau/gitbucket-server
docker push jefferlau/gitbucket-server
# tag gitbucket version 4.13
docker tag gitbucket-server jefferlau/gitbucket-server:4.13
docker push jefferlau/gitbucket-server:4.13
```
获取此镜像。
```bash
docker pull jefferlau/gitbucket-server:lastest
# or
docker pull jefferlau/gitbucket-server:4.13
```
使用此镜像部署服务。
```bash
docker run -p 18080:8080 --name jefferlau-gitbucket -v $PWD/4.13:/root/.gitbucket -d jefferlau/gitbucket-server:4.13
```

- 端口任意定制
- $PWD 指代当前目录，即将宿主机当前目录下的文件夹4.13挂载到 Docker 容器的 /root/.gitbucket 目录
- Go to http://[hostname]:18080/ and log in with ID: root / Pass: root.
