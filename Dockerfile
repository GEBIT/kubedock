# syntax=docker/dockerfile:1.7-labs

####################
## Build kubedock ## ----------------------------------------------------------
####################

FROM docker.io/golang:1.23 AS kubedock

ARG CODE=github.com/joyrex2001/kubedock

WORKDIR /go/src/${CODE}/

COPY go.mod go.sum .
RUN go mod download

ADD --exclude=start-kubedock.sh . ./

RUN make test build \
    && mkdir /app \
    && cp kubedock /app

#################
## Final image ## ------------------------------------------------------------
#################

FROM alpine:3

RUN apk add --no-cache ca-certificates bash \
    && update-ca-certificates

COPY --from=kubedock /app /usr/local/bin
COPY start-kubedock.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/start-kubedock.sh"]
