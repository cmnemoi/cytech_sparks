package cytech_sparks

import org.apache.spark.SparkContext;
import org.apache.spark.SparkConf;
import org.apache.spark.rdd.RDD;

object TitanicETL {
    def extract(spark: SparkContext): RDD[String] = {
        // load titanic files as RDDs
        val titanicPart1 = spark.textFile("data/titanic_part_1.txt")
        val titanicPart2 = spark.textFile("data/titanic_part_2.txt")
        val titanicPart3 = spark.textFile("data/titanic_part_3.gz")

        // combine RDDs into one
        val titanic = titanicPart1.union(titanicPart2).union(titanicPart3)

        titanic
    }

    def load(titanic: RDD[String]): RDD[String] = {
        // write RDD to file
        titanic.saveAsTextFile("data/titanic.csv")

        titanic
    }
    
    def main(args: Array[String]): Unit = {
        val sparkConfig = new SparkConf().setAppName("TitanicETL").setMaster("local")
        val spark = new SparkContext(sparkConfig)
        var extractedTitanic = extract(spark)
        var loadedTitanic = load(extractedTitanic)

        spark.stop()
    }
}