version="0.135.1"

date,version="",""
with open("Version.txt","r") as f:
    s=f.readlines()
    date=s[0][0:-1]
    version=s[1][0:-1]
    
emerged=open("Merge/"+version+"emerged.txt","r",encoding="UTF-8")
eng=emerged.readlines()
merged=open("Merge/"+version+"merged.txt","r",encoding="UTF-8")
chi=merged.readlines()

key=""
engw=""
chiw=""

for i in range(0,len(eng)):
    if("string Key = "in eng[i]):
        position=eng[i].find("\"")
        for x in range(position+1,len(eng[i])-2):
            key+=eng[i][x]
        key+='\n'

for i in range(0,len(eng)):
    if("string Translation = "in eng[i]):
        position=eng[i].find("\"")
        for x in range(position+1,len(eng[i])-2):
            engw+=eng[i][x]
        while(1): #special case, sometimes one sentence will split into two lines
            if(i+1<len(eng)):i=i+1
            if eng[i][0] !="\t" and eng[i][0]!=' ':
                #print(c[i])
                for m in range(0,len(eng[i])-1):
                    engw+=eng[i][m]
            else:engw+='\n';break
for i in range(14,len(chi)):
    if("string Translation = "in chi[i]):
        position=chi[i].find("\"")
        for x in range(position+1,len(chi[i])-2):
            chiw+=chi[i][x]
        while(1):#special case, sometimes one sentence will split into two lines
            if(i+1<len(chi)):i=i+1
            if chi[i][0] !="\t" and chi[i][0]!=' ':
                #print(c[i])
                for m in range(0,len(chi[i])-1):
                    chiw+=chi[i][m]
            else:chiw+='\n';break
        
#output data
aa=open("tanslation/key.txt","w",encoding="UTF-8")
bb=open("tanslation/eng.txt","w",encoding="UTF-8")
cc=open("tanslation/chi.txt","w",encoding="UTF-8")
aa.write(key);bb.write(engw);cc.write(chiw)
aa.close();bb.close();cc.close()