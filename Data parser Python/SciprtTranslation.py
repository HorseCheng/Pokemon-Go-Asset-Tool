import json

version = "", ""
with open("Version.txt", "r") as f:
    s = f.readlines()
    version = s[1][0:-1]
print(version)

with open("Merge/" + version + "chinesetraditional.json", encoding='UTF-8') as f:
    chi = json.load(f)
    chi = chi["data"]
with open("Merge/" + version + "english.json", encoding='UTF-8') as f:
    eng = json.load(f)
    eng = eng["data"]

with open("Merge/patch_i18n_chinesetraditional.json", encoding='UTF-8') as f:
    patch = json.load(f)
    patch = patch["data"]

key = ""
engw = ""
chiw = ""

patchkey = ""
patchchi = ""

for i in range(0,len(chi),2):
    key+=chi[i].replace('\n','').replace('\r','')+'\n'
for i in range(1,len(chi),2):
    chiw+=chi[i].replace('\n','').replace('\r','').replace("_x000D_ "," ")+'\n'
for i in range(1,len(eng),2):
    engw+=eng[i].replace('\n','').replace('\r','')+'\n'

for i in range(0,len(patch),2):
    patchkey+=chi[i].replace('\n','').replace('\r','')+'\n'
for i in range(1,len(patch),2):
    patchchi+=chi[i].replace('\n','').replace('\r','').replace("_x000D_ "," ")+'\n'


# output data
aa = open("Translation/key.txt", "w", encoding="UTF-8")
bb = open("Translation/eng.txt", "w", encoding="UTF-8")
cc = open("Translation/chi.txt", "w", encoding="UTF-8")
dd = open("Translation/patchkey.txt", "w", encoding="UTF-8")
ee = open("Translation/patchchi.txt", "w", encoding="UTF-8")

aa.write(key)
bb.write(engw)
cc.write(chiw)
dd.write(patchkey)
ee.write(patchchi)

aa.close()
bb.close()
cc.close()
dd.close()
ee.close()