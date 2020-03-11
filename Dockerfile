FROM golang:1.13-alpine AS BUILD
RUN apk add --no-cache bash coreutils gcc git musl-dev openssl

WORKDIR /go/src/github.com/ntent/nexus-cli/
ADD . ./

RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux go build -mod=vendor -o nexus-cli .


FROM alpine

RUN    apk add --no-cache bash \
                          ca-certificates \
    && mkdir -p /app

COPY --from=BUILD /go/src/github.com/ntent/nexus-cli/nexus-cli /app/

ENTRYPOINT ["/app/nexus-cli"]
