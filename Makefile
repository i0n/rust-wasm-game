SHELL := /bin/bash
NAME := rust-wasm-game
GCR_NAME := registry.digitalocean.com/i0n/${NAME}
ROOT_PACKAGE := github.com/i0n/rust-wasm-game

BRANCH     := $(shell git rev-parse --abbrev-ref HEAD 2> /dev/null  || echo 'unknown')
BUILD_DATE := $(shell date +%Y%m%d-%H:%M:%S)
BUILD_USER := $(shell whoami)

all: build

check: fmt build test

print-rev:
	@echo $(REV)

print-branch:
	@echo $(BRANCH)

print-build-date:
	@echo $(BUILD_DATE)

print-build-user:
	@echo $(BUILD_USER)

build: 
	cargo build --release --target wasm32-unknown-unknown
	wasm-bindgen --out-dir ./out/ --target web target/wasm32-unknown-unknown/release/my_bevy_game.wasm

docker-build-latest:
	docker build --no-cache . -t ${GCR_NAME}:latest

docker-push:
	docker push ${GCR_NAME}:latest
