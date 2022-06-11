FROM ubuntu:20.04
#ADD  jdk-8u321-linux-x64.tar.gz /root/  && 
#ADD  node-v12.22.10-linux-x64.tar.gz /root/ 
RUN apt-get update  && \
    apt-get install curl wget vim git -y && \
    cd /root/ && \
    wget http://zhangzhuang.vicp.net:9080/down/jdk-8u321-linux-x64.tar.gz  -O /root/jdk-8u321-linux-x64.tar.gz  && \
    wget https://registry.npmmirror.com/-/binary/node/latest-v12.x/node-v12.22.10-linux-x64.tar.gz   -O /root/node-v12.22.10-linux-x64.tar.gz   && \
    tar -xzvf jdk-8u321-linux-x64.tar.gz && \
    tar -xzvf node-v12.22.10-linux-x64.tar.gz && \
    git clone https://gitee.com/jetlinks/jetlinks-community.git && \
    git clone https://gitee.com/jetlinks/jetlinks-ui-antd.git     
RUN echo  'export  JAVA_HOME=/root/jdk1.8.0_321\n\
export NODEJS_HOME=/root/node-v12.22.10-linux-x64\n\  
export PATH=$JAVA_HOME/bin:$NODEJS_HOME/bin:$PATH ' >> /etc/profile  && \
/bin/bash -c 'source /etc/profile'  
RUN cd /root/jetlinks-ui-antd/  && \
    npm set  registry https://registry.npmmirror.com/ && \
    npm install -g yarn && \
    yarn && \
    yarn build
RUN cd /root/jetlinks-community/ && \
    ./mvnw clean package -Dmaven.test.skip=true

