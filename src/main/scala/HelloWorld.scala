package cytech_sparks

import org.apache.spark.sql.SparkSession;

object HelloWorld {
    def main(args: Array[String]): Unit = {
        val spark = SparkSession.builder.appName("Hello, World!").getOrCreate()
        val logFile = "./README.md" // Should be some file on your system
        val logData = spark.read.textFile(logFile).cache()
        val numAs = logData.filter(line => line.contains("a")).count()
        val numBs = logData.filter(line => line.contains("b")).count()
        println(s"Lines with a: $numAs, Lines with b: $numBs")
        spark.stop()
    }
}