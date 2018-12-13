import re
ff=open("1208emerged.txt","r",encoding="UTF-8")
b=ff.readlines()
fff=open("1208merged.txt","r",encoding="UTF-8")
c=fff.readlines()

f=open("20181212.txt",'r',encoding="UTF-8")
a=f.readlines()
Key =''' "pokemon_type_bug"
			string Translation = "蟲"
			string Key = "pokemon_type_dark"
			string Translation = "惡"
			string Key = "pokemon_type_dragon"
			string Translation = "龍"
			string Key = "pokemon_type_electric"
			string Translation = "電"
			string Key = "pokemon_type_fairy"
			string Translation = "妖精"
			string Key = "pokemon_type_fighting"
			string Translation = "格鬥"
			string Key = "pokemon_type_fire"
			string Translation = "火"
			string Key = "pokemon_type_flying"
			string Translation = "飛行"
			string Key = "pokemon_type_ghost"
			string Translation = "幽靈"
			string Key = "pokemon_type_grass"
			string Translation = "草"
			string Key = "pokemon_type_ground"
			string Translation = "地面"
			string Key = "pokemon_type_ice"
			string Translation = "冰"
			string Key = "pokemon_type_normal"
			string Translation = "一般"
			string Key = "pokemon_type_poison"
			string Translation = "毒"
			string Key = "pokemon_type_psychic"
			string Translation = "超能力"
			string Key = "pokemon_type_rock"
			string Translation = "岩石"
			string Key = "pokemon_type_steel"
			string Translation = "鋼"
			string Key = "pokemon_type_water"
			string Translation = "水"'''
Key=Key.split("\n")   
quick =[[],[],[]]
charge=[[],[],[]]
stringquick = ["" for x in range(4)]
stringcharge = ["" for x in range(4)]
index=0
alola=[19,20,26,27,28,37,38,50,51,52,53,74,75,76,88,89,103,105]
for i in range(17000,45000):
    temp=re.search("template_id: \"V[0-9]+_MOVE_",a[i])
    if(temp):

        if("_FAST" in a[i]):qorc=1;
        else:qorc=0
        index=re.search("[0-9]+",a[i]).group()
        if qorc==1:
            quick[0].append(index)
            for e in range(5000,6600):
                if(index in b[e]):
                    position=b[e+1].find("\"")
                    temp=""
                    for x in range(position+1,len(b[e+1])-2):
                        temp+=b[e+1][x]
                    quick[1].append(temp)
                if(index in c[e]):
                        quick[2].append(re.search("[\u4e00-\u9fa5]+",c[e+1]).group())

        else:
            charge[0].append(index)
            for e in range(5000,6600):
                    if(re.search(index,b[e])):
                        position=b[e+1].find("\"")
                        temp=""
                        for x in range(position+1,len(b[e+1])-2):
                            temp+=b[e+1][x]
                        charge[1].append(temp)
                    if(re.search(index,c[e])):
                        charge[2].append(re.search("[\u4e00-\u9fa5]+",c[e+1]).group())
        checkmatrix=[0 for c in range(0,4)]
        for y in range(i,len(a)):
                if("pokemon_type:" in a[y]):
                    i=y;checkmatrix[0]=1
                    position=a[i].find(":")
                    temp=""
                    for tt in range(position+2,len(a[i])-1):
                         temp+=(str(a[i][tt].lower()))
                    for z in range(0,len(Key)):
                        if (temp in Key[z]):
                            if(qorc==1):stringquick[0]+=re.search("[\u4e00-\u9fa5]+",Key[z+1]).group()+'\n';
                            else:stringcharge[0]+=re.search("[\u4e00-\u9fa5]+",Key[z+1]).group()+'\n'
                    continue
                if("power:" in a[y]):
                    i=y;checkmatrix[1]=1
                    position=a[i].find(":")
                    temp=""
                    for ind in range(position+1,len(a[i])):
                        if(qorc==1):stringquick[1]+=a[i][ind]
                        else:stringcharge[1]+=a[i][ind]
                    continue
                if("duration_ms" in a[y]):
                    i=y;checkmatrix[2]=1
                    position=a[i].find(": ")
                    for ind in range(position+1,len(a[i])):
                        if(qorc==1):stringquick[2]+=a[i][ind]
                        else:stringcharge[2]+=a[i][ind]
                    continue
                if("energy_delta:" in a[y]):
                    i=y;checkmatrix[3]=1;
                    position=a[i].find(": ")
                    for ind in range(position+1,len(a[i])):
                        if(qorc==1):stringquick[3]+=a[i][ind]
                        else:stringcharge[3]+=a[i][ind]
                    continue
                if("}" in a[y]):
                    i=y
                    for t in range(0,len(checkmatrix)):
                        if (checkmatrix[t]==0):
                            if(qorc==1):stringquick[t]+='\n'
                            else:stringcharge[t]+='\n'
                    break

with open('move/quick.txt', 'w') as f:
    for i in range(0,len(quick[1])):
        f.write("%s\n" % (quick[1][i]))
    f.close()
with open('move/quickch.txt', 'w') as f:
    for i in range(0,len(quick[2])):
        f.write("%s %s\n" % (quick[0][i],quick[2][i]))
    f.close()
with open('move/charge.txt', 'w') as f:
    for i in range(0,len(charge[1])):
        f.write("%s\n" % (charge[1][i]))
    f.close()
with open('move/chargech.txt', 'w') as f:
    for i in range(0,len(charge[2])):
        f.write("%s %s\n" % (charge[0][i],charge[2][i]))
    f.close()

    
aa=open("move/quick/pokemon_type.txt","w",encoding="UTF-8")
bb=open("move/quick/power.txt","w",encoding="UTF-8")
cc=open("move/quick/duraion.txt","w",encoding="UTF-8")
dd=open("move/quick/energy_delta.txt","w",encoding="UTF-8")
aa.write(stringquick[0]);bb.write(stringquick[1]);cc.write(stringquick[2]);dd.write(stringquick[3]);
aa.close();bb.close();cc.close();dd.close()

    
aa=open("move/charge/pokemon_type.txt","w",encoding="UTF-8")
bb=open("move/charge/power.txt","w",encoding="UTF-8")
cc=open("move/charge/duraion.txt","w",encoding="UTF-8")
dd=open("move/charge/energy_delta.txt","w",encoding="UTF-8")
aa.write(stringcharge[0]);bb.write(stringcharge[1]);cc.write(stringcharge[2]);dd.write(stringcharge[3]);
aa.close();bb.close();cc.close();dd.close()
