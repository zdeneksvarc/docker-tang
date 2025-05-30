FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        tang socat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY tangd-entrypoint /tangd-entrypoint
COPY tangd-healthcheck /tangd-healthcheck

RUN chmod +x /tangd-entrypoint /tangd-healthcheck

VOLUME ["/var/db/tang"]
EXPOSE 80

HEALTHCHECK CMD ["/tangd-healthcheck"]
CMD ["/tangd-entrypoint"]
