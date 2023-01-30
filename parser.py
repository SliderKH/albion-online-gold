import requests
import csv

source = 'https://albion-online-data.com/api/v2/stats/gold?date=01-01-2018&end_date=01-01-2023'
r = requests.get(source).json()
data_file = open('data/gold_data.csv', 'w', newline='')
csv_writer = csv.writer(data_file)
count = 0
for item in r:
    if count == 0:
        header = item.keys()
        csv_writer.writerow(header)
        count += 1
    csv_writer.writerow(item.values())
data_file.close()

# Path: data/gold_data.csv
# Source: Albion Online Data
