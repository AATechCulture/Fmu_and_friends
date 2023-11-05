import csv
import json


def csv_to_json(csv_path, json_path):
    """
    Convert a CSV file to a JSON file.

    Parameters:
    - csv_path: str - Path to the input CSV file
    - json_path: str - Path to the output JSON file
    """

    with open(csv_path, 'r', encoding='utf-8') as csv_file:
        csv_reader = csv.DictReader(csv_file)

        # Convert each row into a dictionary and add it to data
        data = [row for row in csv_reader]

    # Write the data to a JSON file
    with open(json_path, 'w', encoding='utf-8') as json_file:
        json.dump(data, json_file, indent=4)
