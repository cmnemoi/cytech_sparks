package cytech_sparks

import org.apache.spark.SparkContext;
import org.apache.spark.rdd.RDD;
import org.apache.spark.sql.SparkSession;

object TitanicETL {
    def main(args: Array[String]): Unit = {
        val spark = SparkSession.builder().appName("TitanicETL").master("local").getOrCreate()
        var extractedTitanic = extract(spark)
        var loadedTitanic = load(extractedTitanic)
        var transformedTitanic = transform(spark, loadedTitanic)

        spark.stop()
    }

    def extract(spark: SparkSession): RDD[String] = {
        // load titanic files as RDDs
        val titanicPart1 = spark.sparkContext.textFile("data/titanic_part_1.txt")
        val titanicPart2 = spark.sparkContext.textFile("data/titanic_part_2.txt")
        val titanicPart3 = spark.sparkContext.textFile("data/titanic_part_3.gz")

        // combine RDDs into one
        val titanic = titanicPart1.union(titanicPart2).union(titanicPart3)

        titanic
    }

    def load(titanic: RDD[String]): RDD[String] = {
        // write RDD to file
        titanic.saveAsTextFile("data/titanic.csv")

        titanic
    }

    def transform(spark: SparkSession, titanic: RDD[String]) = {
        typeVariables(spark, titanic)
        translateToEnglish(titanic)
    }

    def typeVariables(spark: SparkSession, titanic: RDD[String]) = {
        // convert rdd to dataframe
        import spark.implicits._
        val titanicDataFrame = titanic.toDF()

        // print schema
        titanicDataFrame.printSchema()

    }

    def translateToEnglish(titanic: RDD[String]) = {
        // TODO
    }
}