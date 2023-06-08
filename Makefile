NAME=$(shell sed 's/[\", ]//g' package.json | grep name | cut -d: -f2 | head -1)
DESC=$(shell sed 's/[\",]//g' package.json | grep description | cut -d: -f2 | sed -e 's/^[ \t]*//')
VERSION=$(shell sed 's/[\", ]//g' package.json | grep version | cut -d: -f2)

build: .clear
	@rm -Rf build
	@cd src ; packer build template.json
	@mv src/output-qemu build

install: .clear
	@sudo apt install packer

clean:
	@rm -Rf build dist src/output-qemu src/packer_cache

.clear:
	@clear

help: .clear
	@echo "${DESC} (${NAME} - ${VERSION})"
	@echo "Uso: make [options]"
	@echo ""
	@echo "  build (default)    Build da imagem"
	@echo "  install            Instala as dependências"
	@echo "  clean              Apaga as os arquivos de build do projeto"
	@echo "  help               Exibe esta mensagem de HELP"
	@echo ""

.PHONY: build test
