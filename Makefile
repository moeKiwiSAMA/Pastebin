PROJECT_NAME=pastebin
# Basic go command
GOCMD=go
GOBUILD=$(GOCMD) build
GOClEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
# Pastebin Args
ADDRESS=0.0.0.0
PORT=8082
SECRET=
PUBLIC=


all: build run
build:
	$(GOBUILD) -o $(PROJECT_NAME) main.go
run: build  
	./$(PROJECT_NAME) -address $(ADDRESS) -port $(PORT) -secretkey $(SECRET) -publickey $(PUBLIC)
