all: install

clean: uninstall

install:
	@bash ./scripts/install.sh

uninstall:
	@bash ./scripts/uninstall.sh

jupyter:
	poetry run jupyter notebook