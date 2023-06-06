FROM alpine:edge@sha256:2d01a16bab53a8405876cec4c27235d47455a7b72b75334c614f2fb0968b3f90
LABEL maintainer="Masaki Muranaka <monaka@monami-ya.com>"

RUN apk add --update --no-cache sudo bash bash-completion git openssh-client shadow && \
    adduser -S user -h /home/user -s /bin/bash -G root -u 1000 && \
    usermod -p "*" user && \ 
    apk del --no-cache shadow && \
    echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /projects && \
    for f in /projects /home/user /etc/passwd /etc/group; do \
      chgrp -R 0 $f && \
      chmod -R g+rwX $f ; \
    done && \
    sed s#user:x.*#user:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g /etc/passwd > /.passwd.template && \
    sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g /etc/group > /.group.template
COPY [ "entrypoint.sh", "/entrypoint.sh" ]

VOLUME /projects

USER user
WORKDIR /projects

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "tail", "-f", "/dev/null" ] 
