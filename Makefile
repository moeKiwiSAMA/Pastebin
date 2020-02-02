NAME = moekiwisama/pastebin
VERSION = 1.0.0

.PHONY: build start push

build:build-go PasteBin
	        docker build -t ${NAME}:${VERSION}  .

build-go:
					CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

tag-latest:
	        docker tag ${NAME}:${VERSION} ${NAME}:latest

start:
	        docker run -it --rm ${NAME}:${VERSION}

push:   build-version tag-latest
	        docker push ${NAME}:${VERSION}; docker push ${NAME}:latest
