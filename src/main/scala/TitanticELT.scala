package cytech_sparks

import org.apache.spark.sql.{DataFrame, SparkSession};

object TitanicELT {
    def main(args: Array[String]): Unit = {
        val spark = SparkSession.builder().appName("TitanicETL").master("local").getOrCreate()
        val extractedTitanic = extract(spark)
        val loadedTitanic = load(extractedTitanic)
        val transformedTitanic = transform(spark, loadedTitanic)

        spark.stop()
    }

    def extract(spark: SparkSession): DataFrame = {
        // load titanic files as DataFrames
        val titanicPart1 = spark.read.format("csv").option("header", "true").load("data/titanic_part_1.txt")
        val titanicPart2 = spark.read.format("parquet").load("data/titanic_part_2.parquet")
        val titanicPart3 = spark.read.format("orc").load("data/titanic_part_3.orc")

        // combine DataFrames
        val titanic = titanicPart1.union(titanicPart2).union(titanicPart3)

        titanic
    }

    def load(titanic: DataFrame): DataFrame = {
        // write dataframe to csv
        titanic.write.format("csv").option("header", "true").save("data/titanic.csv")

        titanic
    }

    def transform(spark: SparkSession, titanic: DataFrame) = {
        typeVariables(spark, titanic)
        translateToEnglish(titanic)
    }

    def typeVariables(spark: SparkSession, titanic: DataFrame) = {
        // TODO

    }

    def translateToEnglish(titanic: DataFrame) = {
        // TODO
    }
}