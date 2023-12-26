spark_home=/home/dev/spark

all: build cluster-watch

bash: master-bash

build:
	docker build -t cmnemoi_spark:3.5.0 .

compile:
	docker compose exec -it spark-master \
	sbt package 

cluster-start:
	docker compose up -d

cluster-stop:
	docker compose stop

cluster-watch:
	docker compose up

elt: compile
	rm -rf data/loaded_titanic.csv data/transformed_titanic.csv
	docker compose exec --user dev -it spark-master \
	$(spark_home)/bin/spark-submit \
		--master local \
		--class cytech_sparks.TitanicELT \
		./target/scala-2.12/cytech_sparks_2.12-0.1.0.jar
	cat data/loaded_titanic.csv/part-* > data/_loaded_titanic.csv && cat data/transformed_titanic.csv/part-* > data/_transformed_titanic.csv
	rm -rf data/loaded_titanic.csv data/transformed_titanic.csv
	mv data/_loaded_titanic.csv data/loaded_titanic.csv && mv data/_transformed_titanic.csv data/transformed_titanic.csv

hello-world: compile
	docker compose exec --user dev -it spark-master \
	$(spark_home)/bin/spark-submit \
		--master local \
		--class cytech_sparks.HelloWorld \
		./target/scala-2.12/cytech_sparks_2.12-0.1.0.jar

jupyter:
	docker compose exec --user dev -it spark-master \
	python3 -m jupyter notebook --ip 0.0.0.0

master-bash:
	docker exec --user dev -it spark-master bash

master-spark:
	docker compose exec --user dev -it spark-master $(spark_home)/bin/spark-shell

spark: master-spark

start: cluster-start

stop: cluster-stop

watch: cluster-watch
	
mac-etl:
	opt/bin/spark-submit \
		--master local \
		--class cytech_sparks.MacETL \
		./target/scala-2.12/cytech_sparks_2.12-0.1.0.jar

mac-jupyter:
	poetry run jupyter notebook