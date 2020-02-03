FROM alpine
RUN mkdir /app
ADD script /app
ADD ./bin/pastebin /app/pastebin
ADD public /app/public
WORKDIR /app
RUN apk add redis
RUN rm /usr/bin/redis-cli /usr/bin/redis-benchmark
ENTRYPOINT ["sh", "/app/start.sh"]
