FROM rockylinux/rockylinux:8.6.20220707

ENV SUMMARY="Network Presence Binding Daemon." \
    DESCRIPTION="Tang is a small daemon for binding data to the presence of a third party. This is a containerized Tang server." \
    VERSION=1 \
    TANG_LISTEN_PORT=80

LABEL name="stackhpc/tang" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      version="${VERSION}" \
      usage="podman run -d -p 8080:80 -v tang-keys:/var/db/tang --name tang stackhpc/tang"

RUN dnf update -y && \
    dnf install -y \
             tang \
             socat && \
    dnf clean all && \
    rm -rf /var/cache/yum

COPY root /

VOLUME ["/var/db/tang"]
EXPOSE "${TANG_LISTEN_PORT}"

HEALTHCHECK CMD ["/usr/bin/tangd-healthcheck"]
CMD ["/usr/bin/tangd-entrypoint"]
