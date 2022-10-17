ARG BASE_IMAGE=memcached:alpine

FROM $BASE_IMAGE

LABEL Maintainer="Johann H. <info@itconsulting-hahn.de>" \
      Description="Docker container with memcached based on Alpine Linux."

# Install netcat for healthcheck
USER root
RUN apk --no-cache add netcat-openbsd \
    && rm -rf /var/cache/apk/*

# Switch back to memcache user
USER memcache

HEALTHCHECK --interval=20s --retries=5 --timeout=5s \
  CMD /bin/nc -z 127.0.0.1 11211
