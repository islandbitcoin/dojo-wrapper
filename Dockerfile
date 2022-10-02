FROM --platform=linux/arm64/v8 manjarolinux/base:20220925@sha256:5cb6de95e58beae7b94d564417ea8a324b916b4b90b72945b75cb3fcd306cfab

RUN printf "Y" | pacman -S yq

WORKDIR /root/RoninDojo/

COPY RoninDojo/ .

ADD user.conf /root/.config/RoninDojo/user.conf
ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/*.sh
