FROM docker.io/zmkfirmware/zmk-build-arm:3.5


COPY ./dockerfiles/.bashrc ~/.bashrc

WORKDIR /workspaces/zmk

RUN git clone --recurse-submodules https://github.com/zmkfirmware/zmk.git .

RUN west init -l app/ && west update

COPY ./config zmk-config
COPY ./modules zmk-modules

