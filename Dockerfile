FROM alpine:latest

RUN apk add --no-cache bash curl ruby ruby-etc ruby-webrick

WORKDIR /usr/local/bin
COPY bin/* ./
RUN chmod +x *.sh

# Create a group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
