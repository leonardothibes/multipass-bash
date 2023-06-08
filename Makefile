build: help

install: .clear
	@sudo apt install packer

help: .clear

.clear:
	@clear

.PHONY: build test
