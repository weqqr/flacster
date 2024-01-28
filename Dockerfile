FROM golang:1.21.4-alpine3.18
WORKDIR /app
COPY . .
RUN apk add --no-cache make
RUN apk add --update nodejs npm
RUN npm install /app/ui/
RUN make all
EXPOSE 1337
CMD ["/app/flacster"]
