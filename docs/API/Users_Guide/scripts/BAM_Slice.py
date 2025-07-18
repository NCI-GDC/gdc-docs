import requests
import json

'''
 This script will not work until $TOKEN_FILE_PATH
 is replaced with an actual path.
'''
token_file = "$TOKEN_FILE_PATH"

file_id = "a5b9acbd-adea-47d0-a3a3-3eb6ebfde56b"

data_endpt = "https://api.gdc.cancer.gov/slicing/view/{}".format(file_id)

with open(token_file,"r") as token:
    token_string = str(token.read().strip())

params = {"gencode": ["BRCA1", "BRCA2"]}

response = requests.post(data_endpt,
                        data = json.dumps(params),
                        headers = {
                            "Content-Type": "application/json",
                            "X-Auth-Token": token_string
                            })

file_name = "brca_slices.bam"

with open(file_name, "wb") as output_file:
    output_file.write(response.content)
