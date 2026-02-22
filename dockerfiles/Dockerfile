FROM docker.io/zmkfirmware/zmk-build-arm:4.1-branch


COPY ./dockerfiles/.bashrc ~/.bashrc

WORKDIR /workspaces/zmk

RUN git clone https://github.com/zmkfirmware/zmk.git .

RUN west init -l app/ && west update

COPY ./config zmk-config
COPY ./modules zmk-modules

