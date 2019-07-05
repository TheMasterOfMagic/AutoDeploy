FROM ubuntu:18.04

RUN rm -r /etc/apt/*
COPY ./apt /etc/apt

RUN apt-get update > /dev/null && \
    apt-get install -y sudo > /dev/null

COPY . /root/AutoDeploy

RUN cd /root/AutoDeploy && bash main.sh

WORKDIR /root
CMD ["zsh"]
