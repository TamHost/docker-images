FROM 		--platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

ENV         DEBIAN_FRONTEND=noninteractive

RUN			dpkg --add-architecture i386
RUN apt update
RUN  apt upgrade -y
RUN  apt install -y lib32gcc-s1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus libsdl2-2.0-0:i386
RUN  curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN  apt install -y nodejs
RUN  mkdir /node_modules
RUN  npm install --prefix / ws
RUN  useradd -d /home/container -m container

USER 		container
ENV  		USER=container HOME=/home/container

WORKDIR 	/home/container

COPY 		./entrypoint.sh /entrypoint.sh
COPY 		./wrapper.js /wrapper.js

CMD			[ "/bin/bash", "/entrypoint.sh" ]
