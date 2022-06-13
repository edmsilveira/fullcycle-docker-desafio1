FROM golang as build

WORKDIR /app

COPY main.go ./

RUN go mod init go-rocks && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-s -w -extldflags '-static'" -o /main

FROM scratch

WORKDIR /

COPY --from=build /main /main

ENTRYPOINT ["/main"]