
emerged=open("20181215.txt","rb",encoding="UTF-8")
eng=emerged.readlines()

#Convert Protobuf to JSoN
from google.protobuf.json_format import MessageToJson

jsonObj = MessageToJson(emerged)
