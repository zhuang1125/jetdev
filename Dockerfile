FROM ubuntu:20.04
#ADD  jdk-8u333-linux-x64.tar.gz /root/  && 
#ADD  node-v12.22.10-linux-x64.tar.gz /root/ 
RUN apt-get update  && \
    apt-get install curl wget vim git -y && \
    cd /root/ && \
    wget https://download.oracle.com/otn/java/jdk/8u333-b02/2dee051a5d0647d5be72a7c0abff270e/jdk-8u333-linux-x64.tar.gz?AuthParam=1654846085_52e3d7b535ff004ad50dff7e803539a1  -O /root/jdk-8u333-linux-x64.tar.gz  && \
    wget https://registry.npmmirror.com/-/binary/node/latest-v12.x/node-v12.22.10-linux-x64.tar.gz   -O /root/node-v12.22.10-linux-x64.tar.gz   && \
    tar -xzvf jdk-8u333-linux-x64.tar.gz && \
    tar -xzvf node-v12.22.10-linux-x64.tar.gz && \
    export  JAVA_HOME=/root/jdk1.8.0_333  && \
    export NODEJS_HOME=/root/node-v12.22.10-linux-x64  && \
    export PATH=$JAVA_HOME/bin:$NODEJS_HOME/bin:$PATH  && \
    git clone https://gitee.com/jetlinks/jetlinks-community.git && \
    git clone https://gitee.com/jetlinks/jetlinks-ui-antd.git && \
    cd /root/jetlinks-ui-antd/  && \
    npm set  registry https://registry.npmmirror.com/ && \
    npm install -g yarn && \
    yarn && \
    yarn build && \
    cd /root/jetlinks-community/ && \
    ./mvnw clean package -Dmaven.test.skip=true

