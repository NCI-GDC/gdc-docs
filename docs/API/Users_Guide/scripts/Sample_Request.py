import requests
import json

file_endpt = 'https://api.gdc.cancer.gov/files/'
file_uuid = 'cb92f61d-041c-4424-a3e9-891b7545f351'
response = requests.get(file_endpt + file_uuid)

# OUTPUT METHOD 1: Write to a file.
file = open("sample_request.json", "w")
file.write(response.text)
file.close()

# OUTPUT METHOD 2: View on screen.
print(json.dumps(response.json(), indent=2))
