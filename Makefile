all: build cluster-start

bash: master-bash

build:
	docker build -t cmnemoi_spark:3.5.0 .

compile:
	docker compose exec -it spark-master \
	sbt package 

run-hello-world: compile
	docker compose exec -it spark-master \
	/opt/spark/bin/spark-submit \
		--master local \
		--class cytech_sparks.HelloWorld \
		./target/scala-2.12/cytech_sparks_2.12-0.1.0.jar

cluster-start:
	docker compose up -d

cluster-stop:
	docker compose stop

cluster-watch:
	docker compose up

master-bash:
	docker exec -it spark-master bash

master-spark:
	docker compose exec -it spark-master /opt/spark/bin/spark-shell