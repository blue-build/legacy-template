# This is the Containerfile for your custom image. 

# It takes in the recipe, version, and base image as arguments,
# all of which are provided by build.yml when doing builds
# in the cloud. The ARGs have default values, but changing those
# does nothing if the image is built in the cloud.

ARG FEDORA_MAJOR_VERSION=38
# Warning: changing this might not do anything for you. Read comment above.
ARG BASE_IMAGE_URL=ghcr.io/ublue-os/silverblue-main


FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_MAJOR_VERSION} as keyd_builder
WORKDIR /tmp
RUN dnf upgrade \
  && dnf install wget gcc \
  && wget https://github.com/rvaiya/keyd/archive/refs/tags/v2.4.3.tar.gz \
  && tar xvf v2.4.3.tar.gz \
  && make && sudo make install




FROM ${BASE_IMAGE_URL}:${FEDORA_MAJOR_VERSION}

# The default recipe set to the recipe's default filename
# so that `podman build` should just work for many people.
ARG RECIPE=./recipe.yml

# Copy static configurations and component files.
# Warning: If you want to place anything in "/etc" of the final image, you MUST
# place them in "./usr/etc" in your repo, so that they're written to "/usr/etc"
# on the final system. That is the proper directory for "system" configuration
# templates on immutable Fedora distros, whereas the normal "/etc" is ONLY meant
# for manual overrides and editing by the machine's admin AFTER installation!
# See issue #28 (https://github.com/ublue-os/startingpoint/issues/28).
COPY usr /usr

# Copy the recipe that we're building.
COPY ${RECIPE} /usr/share/ublue-os/recipe.yml

# "yq" used in build.sh and the "setup-flatpaks" just-action to read recipe.yml.
# Copied from the official container image since it's not available as an RPM.
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

COPY --from=keyd_builder /usr/lib/systemd/system/keyd* /usr/lib/systemd/system/keyd.service 
COPY --from=keyd_builder /usr/bin/keyd* /usr/bin/
COPY --from=keyd_builder /usr/share/doc/keyd/ /usr/share/doc/keyd/ 
COPY --from=keyd_builder /usr/share/man/man1/keyd*.gz /usr/share/man/man1/keyd*.gz 

# Copy the build script and all custom scripts.
COPY scripts /tmp/scripts

# Run the build script, then clean up temp files and finalize container build.
RUN chmod +x /tmp/scripts/build.sh && \
        /tmp/scripts/build.sh && \
        rm -rf /tmp/* /var/* && \
        ostree container commit
