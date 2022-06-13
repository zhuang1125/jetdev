FROM ubuntu:20.04
#ADD  jdk-8u321-linux-x64.tar.gz /root/  && 
#ADD  node-v12.22.10-linux-x64.tar.gz /root/ 
SHELL ["/bin/bash", "-c"]
RUN apt-get update  && \
    apt-get install curl wget vim git -y && \
    cd /root/ && \
    wget http://zhangzhuang.vicp.net:9080/down/jdk-8u321-linux-x64.tar.gz  -O /root/jdk-8u321-linux-x64.tar.gz  && \
    wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz  -O /root/apache-maven-3.6.3-bin.tar.gz  && \
    wget https://registry.npmmirror.com/-/binary/node/latest-v12.x/node-v12.22.10-linux-x64.tar.gz   -O /root/node-v12.22.10-linux-x64.tar.gz   && \
    tar -xzvf jdk-8u321-linux-x64.tar.gz && \
    tar -xzvf node-v12.22.10-linux-x64.tar.gz && \
    git clone https://gitee.com/jetlinks/jetlinks-community.git && \
    git clone https://gitee.com/jetlinks/jetlinks-ui-antd.git && \
    git clone https://github.com/thingsboard/thingsboard.git
RUN echo  'export  JAVA_HOME=/root/jdk1.8.0_321' >> /etc/profile && \
    echo 'export NODEJS_HOME=/root/node-v12.22.10-linux-x64' >> /etc/profile && \  
    echo 'export MAVEN_HOME=/root/apache-maven-3.6.3' >> /etc/profile && \ 
    echo 'export PATH=$JAVA_HOME/bin:$NODEJS_HOME/bin:$MAVEN_HOME/bin:$PATH ' >> /etc/profile  && \
    source /etc/profile && \
    cd /root/jetlinks-ui-antd/  && \
    npm set  registry https://registry.npmmirror.com/ && \
    npm install -g yarn && \
    yarn && \
    yarn build && \
    cd /root/jetlinks-community/ && \
    ./mvnw clean package -Dmaven.test.skip=true
    cd /root/thingsboard/ && \
    mvn license:format && \
    mvn clean install package -DskipTests
    
    

