FROM --platform=linux/arm64/v8 manjaroarm/manjaro-arm-base

COPY RoninDojo/ .

ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/*.sh
