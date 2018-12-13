ff=open("1208emerged.txt","r",encoding="UTF-8")
b=ff.readlines()
fff=open("1208merged.txt","r",encoding="UTF-8")
c=fff.readlines()

key=""
eng=""
chi=""

for i in range(0,len(b)):
    if("string Key = "in b[i]):
        position=b[i].find("\"")
        for x in range(position+1,len(b[i])-2):
            key+=b[i][x]
        key+='\n'

for i in range(0,len(b)):
    if("string Translation = "in b[i]):
        position=b[i].find("\"")
        for x in range(position+1,len(b[i])-2):
            eng+=b[i][x]
        while(1):
            if(i+1<len(b)):i=i+1
            if b[i][0] !="\t" and b[i][0]!=' ':
                #print(c[i])
                for m in range(0,len(b[i])-1):
                    eng+=b[i][m]
            else:eng+='\n';break
for i in range(14,len(c)):
    if("string Translation = "in c[i]):
        position=c[i].find("\"")
        for x in range(position+1,len(c[i])-2):
            chi+=c[i][x]
        while(1):
            if(i+1<len(c)):i=i+1
            if c[i][0] !="\t" and c[i][0]!=' ':
                #print(c[i])
                for m in range(0,len(c[i])-1):
                    chi+=c[i][m]
            else:chi+='\n';break
aa=open("tanslation/key.txt","w",encoding="UTF-8")
bb=open("tanslation/eng.txt","w",encoding="UTF-8")
cc=open("tanslation/chi.txt","w",encoding="UTF-8")
aa.write(key);bb.write(eng);cc.write(chi)

aa.close();bb.close();cc.close()
