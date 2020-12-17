import json
version = "", ""
with open("Version.txt", "r") as f:
    s = f.readlines()
    version = s[1][0:-1]
print(version)

with open("Merge/" + version + "chinesetraditional.json", encoding='UTF-8') as f:
    chi = json.load(f)
    chi= chi["data"]
with open("Merge/" + version + "english.json", encoding='UTF-8') as f:
    eng = json.load(f)
    eng = eng["data"]

key = ""
engw = ""
chiw = ""

for i in range(0,len(chi),2):
    key+=chi[i].replace('\n','').replace('\r','')+'\n'
for i in range(1,len(chi),2):
    chiw+=chi[i].replace('\n','').replace('\r','')+'\n'
for i in range(1,len(eng),2):
    engw+=eng[i].replace('\n','').replace('\r','')+'\n'
    
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