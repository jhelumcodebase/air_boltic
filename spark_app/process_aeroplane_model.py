import json
from pyspark.sql import SparkSession

# Initialize Spark session with BigQuery support
spark = SparkSession.builder \
    .appName("Aeroplane Model Processing") \
    .config("spark.jars.packages", "com.google.cloud.spark:spark-bigquery-with-dependencies_3.1.0:0.25.0") \
    .getOrCreate() # here we can also provide configuartions AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to fetch json file stored in S3

# Load JSON data from a file with specified encoding
with open('/opt/spark-app/aeroplane_model.json', encoding='utf-8') as json_file:
    data = json.load(json_file) # here we can also provide the path of s3 bucket if json was stored in s3 bucket

# Flatten the JSON
records = []
for manufacturer, models in data.items():
    for model, details in models.items():
        record = {
            'manufacturer': manufacturer,
            'model': model,
            **details  # unpack details dictionary
        }
        records.append(record)

# Convert the list of records to a DataFrame
df = spark.createDataFrame(records)

# Print schema to inspect the structure
df.printSchema()

# Show a few records
df.show(truncate=False)

# Save DataFrame to BigQuery
# Replace 'your_project.your_dataset.your_table' with your actual project, dataset, and table name
# df.write.format("bigquery") \
#     .option("table", "intricate-abbey-396419.air_boltic.aeroplane_model") \
#     .save()
df.write.csv("output/aeroplane_model.csv", header=True, mode='overwrite') # to save in local
df.write.format("bigquery").option("table", "intricate-abbey-396419.air_boltic.aeroplane_model") \
.option("credentialsFile", "/opt/spark-app/intricate-abbey-396419-d0f76cf73d15.json") \
.option("project", "intricate-abbey-396419") \
.option("writeMethod", "direct").save()


# Stop the Spark session
spark.stop()
