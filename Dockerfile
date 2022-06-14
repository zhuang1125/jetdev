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
    tar -xzvf apache-maven-3.6.3-bin.tar.gz && \
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
    yarn build 
RUN source /etc/profile && \
    cd /root/jetlinks-community/ && \
    ./mvnw clean package -Dmaven.test.skip=true
RUN source /etc/profile && \    
    cd /root/thingsboard/ && \
    git checkout release-3.3 && \ 
    mvn license:format && \
    mvn clean install package -DskipTests
    #&& \
    #git checkout master && \ 
    #mvn license:format && \
    #mvn clean install package -DskipTests
RUN cd /root && wget  https://download.jetbrains.com.cn/idea/gateway/JetBrainsGateway-222.2270.16.exe -O /root/JetBrainsGateway-222.2270.16.exe && \
    wget https://vscode.cdn.azure.cn/stable/4af164ea3a06f701fe3e89a2bcbb421d2026b68f/VSCode-win32-x64-1.68.0.zip -O /root/VSCode-win32-x64-1.68.0.zip && \
    wget https://download.jetbrains.com/idea/ideaIU-222.2964.55.tar.gz -O /root/ideaIU-222.2964.55.tar.gz && \
    wget wget https://update.code.visualstudio.com/commit:4af164ea3a06f701fe3e89a2bcbb421d2026b68f/server-linux-x64/stable  -O /root/vscode-server-linux-x64.tar.gz
RUN apt-get install openssh-client openssh-server  language-pack-zh-hans -y && \
    echo "export LC_ALL=zh_CN.UTF-8">> /etc/profile && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    echo '123456' | passwd --stdin root && \
    /etc/init.d/ssh start
    
    
    
    

