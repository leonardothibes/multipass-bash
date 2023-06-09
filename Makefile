NAME=$(shell sed 's/[\", ]//g' package.json | grep name | cut -d: -f2 | head -1)
DESC=$(shell sed 's/[\",]//g' package.json | grep description | cut -d: -f2 | sed -e 's/^[ \t]*//')
VERSION=$(shell sed 's/[\", ]//g' package.json | grep version | cut -d: -f2)

build: .clear .chmod
	@rm -Rf build
	@cd src ; ../bin/packer build template.json
	@mv src/output-qemu build

install: .clear
	# @sudo apt install packer

clean:
	@rm -Rf build dist src/output-qemu

reset: clean
	@rm -Rf src/packer_cache

.clear:
	@clear

.chmod:
	@chmod 755 ./bin/*

help: .clear
	@echo "${DESC} (${NAME} - ${VERSION})"
	@echo "Uso: make [options]"
	@echo ""
	@echo "  build (default)    Build da imagem"
	@echo "  install            Instala as dependências"
	@echo ""
	@echo "  clean              Apaga as os arquivos de build"
	@echo "  reset              Retorna o projeto ao seu estado original"
	@echo ""
	@echo "  help               Exibe esta mensagem de HELP"
	@echo ""

.PHONY: build test
