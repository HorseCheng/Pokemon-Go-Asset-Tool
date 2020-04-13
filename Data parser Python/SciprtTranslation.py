import json
date, version = "", ""
with open("Version.txt", "r") as f:
    s = f.readlines()
    date = s[0][0:-1]
    version = s[1][0:-1]

with open("Merge/" + version + "chinesetraditional.json") as f:
    chi = json.load(f)
    chi= chi["data"]
with open("Merge/" + version + "english.json") as f:
    eng = json.load(f)
    eng = eng["data"]

key = ""
engw = ""
chiw = ""
for i in range(0,len(chi),2):
    key+=chi[i].replace('\n','')+'\n'
for i in range(1,len(chi),2):
    chiw+=chi[i].replace('\n','')+'\n'
for i in range(1,len(eng),2):
    engw+=eng[i].replace('\n','')+'\n'
# output data
aa = open("Translation/key.txt", "w", encoding="UTF-8")
bb = open("Translation/eng.txt", "w", encoding="UTF-8")
cc = open("Translation/chi.txt", "w", encoding="UTF-8")
aa.write(key)
bb.write(engw)
cc.write(chiw)
aa.close()
bb.close()
cc.close()
print(version)