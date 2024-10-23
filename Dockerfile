FROM --platform=$BUILDPLATFORM alpine:3.16.0 as downloader

ARG POCKETBASE_VERSION=0.7.9
ARG TARGETARCH
ARG TARGETPLATFORM

RUN apk update && apk add curl wget unzip
RUN addgroup -S pocketbase && adduser -S pocketbase -G pocketbase
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        wget https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip -O '/tmp/pocketbase.zip'; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64/v7" ]; then \
        wget https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_armv7.zip -O '/tmp/pocketbase.zip'; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        wget https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_arm64.zip -O '/tmp/pocketbase.zip'; \
    fi

FROM alpine:3.16.0

COPY --from=downloader /tmp/pocketbase.zip /tmp/pocketbase.zip

RUN apk update && apk add unzip

RUN unzip /tmp/pocketbase.zip -d /usr/local/bin/
RUN rm /tmp/pocketbase.zip

RUN addgroup -S pocketbase && adduser -S pocketbase -G pocketbase
RUN chown pocketbase:pocketbase /usr/local/bin/pocketbase
RUN mkdir /pb_data
RUN chown pocketbase:pocketbase /pb_data
RUN mkdir /pb_migrations
RUN chown pocketbase:pocketbase /pb_migrations
RUN chmod 710 /usr/local/bin/pocketbase

VOLUME /pb_data
VOLUME /pb_public
VOLUME /pb_migrations

USER pocketbase
EXPOSE 8090

ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data", "--publicDir=/pb_public", "--migrationsDir=/pb_migrations"]
