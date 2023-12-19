# Etape 1: Construction de l'image
FROM openjdk:11.0.11-jre-slim-buster as builder

RUN apt-get update -y -q && apt-get install -y -q curl wget

ENV SPARK_VERSION=3.5.0 \
HADOOP_VERSION=3 \
SPARK_HOME=/opt/spark

# On télécharge Spark
RUN wget --no-verbose -O apache-spark.tgz "https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
&& mkdir -p $SPARK_HOME \
&& tar -xf apache-spark.tgz -C $SPARK_HOME --strip-components=1 \
&& rm apache-spark.tgz

# On télécharge coursier
RUN curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs \
&& chmod +x cs \
&& ./cs setup --yes --install-dir /usr/bin

# Etape 2 : On configure Spark
FROM builder as apache-spark

EXPOSE 8080 7077 6066

ENV SPARK_MASTER_PORT=7077 \
SPARK_MASTER_WEBUI_PORT=8080 \
SPARK_LOG_DIR=/opt/spark/logs \
SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
SPARK_WORKER_WEBUI_PORT=8080 \
SPARK_WORKER_PORT=7000 \
SPARK_MASTER="spark://spark-master:7077" \
SPARK_WORKLOAD="master"

RUN mkdir -p $SPARK_LOG_DIR && \
touch $SPARK_MASTER_LOG && \
touch $SPARK_WORKER_LOG && \
ln -sf /dev/stdout $SPARK_MASTER_LOG && \
ln -sf /dev/stdout $SPARK_WORKER_LOG

COPY . /cytech_sparks

WORKDIR /cytech_sparks

CMD ["/bin/bash", "/cytech_sparks/start_spark.sh"]