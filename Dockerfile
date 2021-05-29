FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV STACK_DIR /var/opt
ENV BOT_DIR ${STACK_DIR}/pt
ENV USER profittrailer
ENV PASSWORD profittrailer

# ProfitTrailerManager
EXPOSE 10000
# ProfitTrailer bot rainge
EXPOSE 8081-8090
# PTMagic
EXPOSE 5000
# ssh
EXPOSE 22

RUN apt-get update \
    && apt-get install -qq -y apt-utils

# Setup Environment
RUN apt-get update -qq -y \ 
    && apt install -qq -y --no-install-recommends software-properties-common \
    apt-transport-https \
    apt-utils \
    wget \
    git \
    gnupg \
    ssh \
    sudo \
    apache2 \
    nodejs \
    unzip \
    nano \
    npm \
    ssh

# Setup user account.
RUN groupadd -r ${USER} -g 433 \
    && useradd -u 1001 -r -g ${USER} -m -s /bin/bash ${USER} \
    && echo "${USER}:${PASSWORD}" | chpasswd \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Fetch and install dependencies
WORKDIR /tmp
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
    && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && wget -q https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb \
    && mkdir -p /usr/share/man/man1 \
    && apt install -qq -y --no-install-recommends ./packages-microsoft-prod.deb \
    && apt update -qq -y \
    && apt install -qq -y --no-install-recommends adoptopenjdk-8-hotspot \
    dotnet-runtime-3.1 \
    aspnetcore-runtime-3.1 \
    && a2enmod proxy proxy_http proxy_html \
    && wget -qO /etc/apache2/conf-enabled/PTMagic.conf \
    https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/PTMagic.conf \
    && wget -qO /pm2-PT-stack.json https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/pm2-PT-stack.json \
    && wget -qO /home/${USER}/firstrun.sh \
    https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/firstrun.sh \
    && chmod +x /home/${USER}/firstrun.sh \
    && wget -qO /bootstrap.sh \
    https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/bootstrap.sh \
    && chmod +x /bootstrap.sh \    
    && npm install pm2@latest -g \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/profittrailer/
RUN chown -R ${USER}:${USER} ${STACK_DIR} \
    && chown -R ${USER}:${USER} /home/${USER} \
    && rm -rf /tmp/*
CMD service ssh start \
    && service apache2 start \
    && pm2-runtime start /pm2-PT-stack.json
