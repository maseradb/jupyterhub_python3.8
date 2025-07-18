from pyspark.sql import SparkSession

# TODO: Replace 'local[*]' with your external Spark master URL, e.g., 'spark://host:port'
spark = SparkSession.builder \
    .appName('PySparkClusterTest') \
    .master('local[*]') \
    .getOrCreate()

# Create a simple DataFrame
data = [(1, 'Alice'), (2, 'Bob'), (3, 'Charlie')]
df = spark.createDataFrame(data, ['id', 'name'])

df.show()

print('PySpark version:', spark.version)
spark.stop()
