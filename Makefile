all:
	@bash scripts/install_spark_environment.sh

install-miniconda:
	@bash scripts/install_miniconda.sh

jupyter:
	jupyter notebook