name := "cytech_sparks"
version := "0.1.0"
scalaVersion := "2.12.18"

libraryDependencies += "org.apache.spark" %% "spark-core" % "3.5.0" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.5.0"
libraryDependencies += "org.apache.spark" %% "spark-mllib" % "3.5.0"
libraryDependencies += "org.apache.spark" %% "spark-graphx" % "3.5.0"