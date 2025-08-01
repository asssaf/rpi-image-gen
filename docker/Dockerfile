# syntax=docker/dockerfile:experimental
FROM --platform=linux/arm64 debian:latest AS deps

RUN apt update
RUN apt install -y git

RUN git clone https://github.com/raspberrypi/rpi-image-gen.git

RUN /rpi-image-gen/install_deps.sh

RUN useradd -m user

RUN chown -R user /rpi-image-gen

ADD entrypoint.sh /

ENV USER user
USER user
ENTRYPOINT ["/entrypoint.sh"]
