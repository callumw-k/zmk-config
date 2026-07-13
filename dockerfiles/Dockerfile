FROM docker.io/zmkfirmware/zmk-build-arm:3.5

COPY ./dockerfiles/.bashrc ~/.bashrc

WORKDIR /workspaces/zmk

COPY ./config/west.yml ./config/west.yml

RUN west init -l config/ && west update

COPY ./config ./config
