FROM alpine:3.6

ENV HUGO_VERSION 0.25.1
ENV HUGO_BASE_URL "localhost"

RUN apk add --update --no-cache \
        bash \
        ca-certificates \
        curl \
        su-exec \
        tar

WORKDIR /tmp/hugo
RUN curl -o hugo.tar.gz -SL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar -xf hugo.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/hugo

VOLUME /hugo/site
WORKDIR /hugo/site

EXPOSE 1313

COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "hugo", "server" ]
