FROM docker.io/zmkfirmware/zmk-build-arm:3.5


COPY ./dockerfiles/.bashrc ~/.bashrc

WORKDIR /workspaces/zmk

RUN git clone https://github.com/zmkfirmware/zmk.git . && git checkout v0.3

RUN west init -l app/ && west update

COPY ./config zmk-config
COPY ./modules zmk-modules

