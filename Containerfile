ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/ublue-os/silverblue-main:${FEDORA_MAJOR_VERSION}

COPY etc /etc
# COPY usr /usr

COPY ublue-firstboot /usr/bin
COPY recipe.yml /etc/ublue-recipe.yml

COPY build.sh /tmp/build.sh

COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

RUN /tmp/build.sh

RUN rm -rf \
        /tmp/* \
        /var/* && \
    ostree container commit
