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

etl: compile
	docker compose exec --user dev -it spark-master \
	$(spark_home)/bin/spark-submit \
		--master local \
		--class cytech_sparks.TitanicETL \
		./target/scala-2.12/cytech_sparks_2.12-0.1.0.jar
	cat data/titanic.csv/part-* > data/titanic_.csv
	rm -rf data/titanic.csv
	mv data/titanic_.csv data/titanic.csv

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
	