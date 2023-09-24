all:
	@bash scripts/install_spark_environment.sh

uninstall:
	@bash scripts/uninstall_miniconda.sh
	@bash scripts/uninstall_spark_environment.sh

install-miniconda:
	@bash scripts/install_miniconda.sh

jupyter:
	jupyter notebook