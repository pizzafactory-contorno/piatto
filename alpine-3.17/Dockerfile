FROM alpine:3.17@sha256:4c072cac55733e529ec8e69fb85f582d10a6da09109f8415905270197c1a785a
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
