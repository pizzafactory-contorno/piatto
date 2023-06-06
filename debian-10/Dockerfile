FROM debian:10-slim@sha256:9d0fb5b9d5318bf507d4507fc846e36a55de7a1198bfc63cf12a2f7c99011efa
LABEL maintainer="Masaki Muranaka <monaka@monami-ya.com>"

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo git vim openssh-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    adduser --system --home /home/user --shell /bin/bash --uid 1000 --group --disabled-password user && \
    adduser user root && \
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
