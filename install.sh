apt update
apt install -y build-essential gcc git make python python3 python-pip python3-pip wget curl zip
cd $HOME && wget -c https://ftp.shu.aixinwu.org/linuxsoftware/c9sdk.zip && unzip c9sdk.zip
cd $HOME/core-master && scripts/install-sdk.sh
wget -c https://mirrors.shu.edu.cn/node/latest/node-v9.7.0-linux-x64.tar.gz && tar zxf node-v9.7.0-linux-x64.tar.gz && mv node-v9.7.0-linux-x64 node && rm node-v9.7.0-linux-x64.tar.gz
server.js -p 8080 -a zhonger:zhonger --listen 0.0.0.0