FROM golang:1.13.5-alpine as builder

RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go build -o main cmd/server/main.go

FROM alpine
RUN mkdir /app
RUN adduser -S -D -H -h /app appuser
COPY --from=builder /build/main /app
WORKDIR /app
CMD ["./main"]
