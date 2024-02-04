.DEFAULT_GOAL := build

fmt:
	go fmt

lint: fmt
	staticcheck

vet: lint
	go vet

test: vet
	go test

build: test
	go mod tidy
	go build -o terraform/ecs/bootstrap

dev: build
	terraform/ecs/bootstrap

push: build
	./push_image.sh

.PHONY: fmt lint vet test build dev push
