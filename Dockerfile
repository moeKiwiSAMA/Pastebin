FROM redis:5.0.7-alpine
RUN mkdir /app
ADD script /app
ADD ./bin/pastebin /app/pastebin
ADD public /app/public
WORKDIR /app
ENTRYPOINT ["sh", "/app/start.sh"]
