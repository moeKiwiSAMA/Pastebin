NAME = moekiwisama/pastebin
VERSION = 1.0.0

.PHONY: build start push

build:build-go bin/pastebin
	        docker build -t ${NAME}:${VERSION}  .

build-go:
					CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/pastebin

tag-latest:
	        docker tag ${NAME}:${VERSION} ${NAME}:latest

start:
	        docker run -it --rm ${NAME}:${VERSION}

push:   build tag-latest
	        docker push ${NAME}:${VERSION}; docker push ${NAME}:latest
