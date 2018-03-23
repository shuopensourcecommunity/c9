# c9
FROM shuosc/ubuntu:latest
MAINTAINER zhonger <zhonger@live.cn>

RUN apt update && apt upgrade -y && \
    apt install -y curl wget vim build-essential gcc git make python2.7 python-dev python3 python3-dev python-pip python3-pip && \
    apt install -y apache2-dev apt python-setuptools apt-transport-https && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash && \
    . /root/.nvm/nvm.sh && nvm install v9.8.0

# get c9 and checkout temp fix for missing plugin
RUN git clone https://github.com/c9/core.git /c9 && \
    cd /c9 && \
    scripts/install-sdk.sh

# use bash during build
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# install some extra dev goodies like
# * apache support for older versions of php in apache via phpbrew
# * pip for installing CodeIntel in c9

RUN pip install -U pip && \
    pip3 install -U pip && \
    pip3 install -U virtualenv && \
    virtualenv --python=python2 $HOME/.c9/python2 && \
    source $HOME/.c9/python2/bin/activate && \
    mkdir /tmp/codeintel && pip install --download /tmp/codeintel codeintel==0.9.3

# add hub 2.2.9
RUN cd /opt && \
    wget https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz && \
    tar -zxvf hub-linux-amd64-2.2.9.tgz && \
    ln -s /opt/hub-linux-amd64-2.2.9/bin/hub /usr/local/bin/hub

# add zsh
RUN apt update && apt-get install -y zsh git-core && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh

RUN mkdir /workspace && mkdir /root/.pip

COPY pip.conf /root/.pip/pip.conf
COPY sources.lsit /etc/apt/sources.list

ARG c9port=80
ARG user=c9
ARG pass=rules
ARG workspace=/workspace

ENV c9port $c9port
ENV user $user
ENV pass $pass
ENV workspace $workspace

EXPOSE 80

CMD /root/.nvm/versions/node/v9.8.0/bin/node /c9/server.js -p $c9port -a $user:$pass --listen 0.0.0.0 -w $workspace
