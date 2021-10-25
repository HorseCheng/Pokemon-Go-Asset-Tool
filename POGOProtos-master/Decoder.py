import lib.Rpc_pb2 as proto
from google.protobuf.json_format import MessageToJson
import re
import natsort
import os

response = proto.DownloadGmTemplatesResponseProto()

input_file = None

# Read the input file and decode
with open('v2_GAME_MASTER', 'rb') as in_file:
	input_file = in_file.read()
	response.ParseFromString(input_file)

# Convert the decoded file to Json format
response = MessageToJson(response)

# Output file 
with open('GAME_MASTER.json', 'w') as out_file:
	out_file.write(response)

# Backup input and output files to the "versions" folder
timestamp = re.findall('"batchId": "([0-9]+)"', response[-1000:])[0]
versions_list = os.listdir("versions")

if timestamp not in versions_list:
	os.mkdir(f"versions/{timestamp}")

with open(f"versions/{timestamp}/GAME_MASTER.protobuf", 'wb') as out_file:
	out_file.write(input_file)
with open(f"versions/{timestamp}/GAME_MASTER.json", 'w') as out_file:
	out_file.write(response)


# Check whether the output file is the latest one
versions_list = natsort.natsorted(versions_list)

if int(timestamp) > int(versions_list[0]):
	# This output file is the latest one -> overwrite the files in "latest" folder
	with open(f"versions/latest/GAME_MASTER.protobuf", 'wb') as out_file:
  		out_file.write(input_file)
	with open(f"versions/latest/GAME_MASTER.json", 'w') as out_file:
  		out_file.write(response)
	with open(f"versions/latest-version.txt", "w") as out_file:
		out_file.write(timestamp)

print('Success to decode as "GAME_MASTER.json"!')
print(f"Timestamp : {timestamp}")
