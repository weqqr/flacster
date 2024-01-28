FROM golang:1.21.4-alpine3.18
WORKDIR /app
COPY . .
RUN mkdir -p /app/music
RUN apk add --no-cache make
RUN apk add --update nodejs npm
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.0/migrate.linux-amd64.tar.gz | tar xvz
RUN npm install /app/ui/
RUN make all
EXPOSE 1337
CMD ["/app/flacster"]
