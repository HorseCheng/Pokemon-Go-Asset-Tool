import re

date,version="",""
with open("Version.txt","r") as f:
    s=f.readlines()
    date=s[0][0:-1]
    version=s[1][0:-1]

emerged=open("Merge/"+version+"emerged.txt","r",encoding="UTF-8")
eng=emerged.readlines()
merged=open("Merge/"+version+"merged.txt","r",encoding="UTF-8")
chi=merged.readlines()
masterfile=open("Game_Master/"+date+".txt",'r',encoding="UTF-8")
master=masterfile.readlines()

#find chinese name for type name
Key=[[],[]] #String, Traslation

for x in range(len(chi)): 
    if("pokemon_type_" in chi[x]):
        Key[0].append(chi[x])
        Key[1].append(re.search("[\u4e00-\u9fa5]+",chi[x+1]).group())
    if("pokemon_unfavorite_error" in chi[x]):break;

quick =[[],[],[]] #0:Index #1:Eng Name #2:Chi Name
charge=[[],[],[]] #0:Index #1:Eng Name #2:Chi Name
stringquick = ["" for x in range(6)] #1:Type #2:Power #3:Duration #4:Energy Delta
stringcharge = ["" for x in range(6)] #1:Type #2:Power #3:Duration #4:Energy Delta
stringquickpvp = ["" for x in range(3)] #1:Power #2:Energy Delta #3:Duration_turn 
stringchargepvp = ["" for x in range(3)] #1:Power #2:Energy Delta

index=0 #Move index
noww=0  #have searched to which line

def move_info(index,qorc,position,battletype):
    temp=re.search("[0-9\-\.]+",master[position]).group()# find the coefficient
    if battletype=='gym':
        if(qorc==1):stringquick[index]+=(temp+'\n')
        else:stringcharge[index]+=(temp+'\n')
    else:
        if(qorc==1):stringquickpvp[index]+=(temp+'\n')
        else:stringchargepvp[index]+=(temp+'\n')
        
for i in range(0,len(master)): #Find the Move info for Gym, Raid
    if("camera_aerialace" in master[i]):break 
    temp=re.search("template_id: \"V[0-9]+_MOVE_",master[i])
    if(temp):
        if("_FAST" in master[i]):qorc=1; #qorc: quick attack or charge attack
        else:qorc=0
        index=re.search("[0-9]+",master[i]).group()
        if qorc==1: #quick attack
            quick[0].append(index)
            for e in range(noww,len(eng)):
                if("move_reroll_confirm_desc" in eng[e]):break
                if("move_name_" in eng[e] and index in eng[e]):
                    position=eng[e+1].find("\"")  #find the position of "MOVE NAME"
                    temp=""
                    for x in range(position+1,len(eng[e+1])-2):
                        temp+=eng[e+1][x]
                    quick[1].append(temp)
                    noww=e
                if("move_name_" in chi[e] and index in chi[e]):
                        quick[2].append(re.search("[\u4e00-\u9fa5]+",chi[e+1]).group())#Search for chinese word
                        break
        else: #charge attack
            charge[0].append(index)
            for e in range(noww,len(eng)):
                if("move_reroll_confirm_desc" in eng[e]):break
                if("move_name_" in eng[e] and index in eng[e]):
                    position=eng[e+1].find("\"")
                    temp=""
                    for x in range(position+1,len(eng[e+1])-2):
                        temp+=eng[e+1][x]
                    noww=e
                    charge[1].append(temp)
                if("move_name_" in chi[e] and index in chi[e]):
                    charge[2].append(re.search("[\u4e00-\u9fa5]+",chi[e+1]).group())
                    break
                
        #Search Detailed move information in Game Master       
        checkmatrix=[0 for c in range(0,6)] #check whether the move information is not showed in Game Master
        for y in range(i,len(master)):
                if("pokemon_type:" in master[y]):
                    checkmatrix[0]=1 #not empty
                    position=master[y].find(":")
                    temp=""
                    for tt in range(position+2,len(master[y])-1):
                         temp+=(str(master[y][tt].lower()))
                    for z in range(0,len(Key[0])):
                        if (temp in Key[0][z]): #find chinese word
                            if(qorc==1):stringquick[0]+=Key[1][z]+'\n';
                            else:stringcharge[0]+=Key[1][z]+'\n'
                    continue
                if("power:" in master[y]):
                    checkmatrix[1]=1 #not empty
                    move_info(1,qorc,y,'gym')
                    continue
                if("duration_ms" in master[y]):
                    checkmatrix[2]=1 #not empty
                    move_info(2,qorc,y,'gym')
                    continue
                if("energy_delta:" in master[y]):
                    checkmatrix[3]=1 #not empty
                    move_info(3,qorc,y,'gym')
                    continue
                if("damage_window_start_ms:" in master[y]):
                    checkmatrix[4]=1 #not empty
                    move_info(4,qorc,y,'gym')
                    continue
                if("damage_window_end_ms:" in master[y]):
                    checkmatrix[5]=1 #not empty
                    move_info(5,qorc,y,'gym')
                    continue
                if("}" in master[y]):
                    for t in range(0,len(checkmatrix)):
                        if (checkmatrix[t]==0):#info not in Game Master
                            if(qorc==1):stringquick[t]+=' \n'
                            else:stringcharge[t]+=' \n'
                    i=y;break
                
for i in range(0,len(master)): #Find the Move info for PVP
    if("ENCOUNTER_SETTINGS" in master[i]):break
    temp=re.search("template_id: \"COMBAT_V[0-9]+_MOVE_",master[i])
    if(temp):
        if("_FAST" in master[i]):qorc=1; #qorc: quick attack or charge attack
        else:qorc=0
        index=re.search("[0-9]+",master[i]).group()
        checkmatrix=[0 for c in range(0,3)] #check whether the move information is not showed in Game Master
        for y in range(i,len(master)):
                if("power:" in master[y]):
                    checkmatrix[0]=1 #not empty
                    move_info(0,qorc,y,'combat')
                    continue
                if("duration_turns:" in master[y]):
                    checkmatrix[2]=1 #not empty
                    move_info(2,qorc,y,'combat')
                    continue
                if("energy_delta:" in master[y]):
                    checkmatrix[1]=1 #not empty
                    move_info(1,qorc,y,'combat')
                    continue
                if("}" in master[y]):
                    for t in range(0,len(checkmatrix)):
                        if (checkmatrix[t]==0):#info not in Game Master
                            if(qorc==1):stringquickpvp[t]+=' \n'
                            else:stringchargepvp[t]+=' \n'
                    i=y;break
print(stringquickpvp[2])

i=0
while i<len(stringquickpvp[2]):
    if(stringquickpvp[2][i]==" "):stringquickpvp[2]=stringquickpvp[2][:i] + '1' + stringquickpvp[2][i+1:]
    else:stringquickpvp[2]=stringquickpvp[2][:i] + str(int(stringquickpvp[2][i])+1) + stringquickpvp[2][i+1:]
    i+=2

#print(quick[2])     
    
#output data              
with open('move/quick.txt', 'w') as f:
    for i in range(0,len(quick[1])):
        f.write("%s\n" % (quick[1][i]))
    f.close()
with open('move/quickch.txt', 'w',encoding="UTF-8") as f:
    for i in range(0,len(quick[2])):
        f.write("%s %s\n" % (quick[0][i],quick[2][i]))
    f.close()
with open('move/charge.txt', 'w') as f:
    for i in range(0,len(charge[1])):
        f.write("%s\n" % (charge[1][i]))
    f.close()
with open('move/chargech.txt', 'w',encoding="UTF-8") as f:
    for i in range(0,len(charge[2])):
        f.write("%s %s\n" % (charge[0][i],charge[2][i]))
    f.close()

aa=open("move/quick/pokemon_type.txt","w",encoding="UTF-8")
bb=open("move/quick/power.txt","w",encoding="UTF-8")
cc=open("move/quick/duration.txt","w",encoding="UTF-8")
dd=open("move/quick/energy_delta.txt","w",encoding="UTF-8")
ee=open("move/quick/start.txt","w",encoding="UTF-8")
ff=open("move/quick/end.txt","w",encoding="UTF-8")
aa.write(stringquick[0]);bb.write(stringquick[1]);cc.write(stringquick[2]);dd.write(stringquick[3]);ee.write(stringquick[4]);ff.write(stringquick[5]);
aa.close();bb.close();cc.close();dd.close();ee.close();ff.close()

aa=open("move/charge/pokemon_type.txt","w",encoding="UTF-8")
bb=open("move/charge/power.txt","w",encoding="UTF-8")
cc=open("move/charge/duration.txt","w",encoding="UTF-8")
dd=open("move/charge/energy_delta.txt","w",encoding="UTF-8")
ee=open("move/charge/start.txt","w",encoding="UTF-8")
ff=open("move/charge/end.txt","w",encoding="UTF-8")
aa.write(stringcharge[0]);bb.write(stringcharge[1]);cc.write(stringcharge[2]);dd.write(stringcharge[3]);ee.write(stringcharge[4]);ff.write(stringcharge[5]);
aa.close();bb.close();cc.close();dd.close();ee.close();ff.close()

aa=open("move/quick/pvppower.txt","w",encoding="UTF-8")
bb=open("move/quick/pvpenergy_delta.txt","w",encoding="UTF-8")

aa.write(stringquickpvp[0]);bb.write(stringquickpvp[1])
aa.close();bb.close();

aa=open("move/charge/pvppower.txt","w",encoding="UTF-8")
bb=open("move/charge/pvpenergy_delta.txt","w",encoding="UTF-8")
aa.write(stringchargepvp[0]);bb.write(stringchargepvp[1]);
aa.close();bb.close()

s=open("move/quick/pvpduration.txt","w",encoding="UTF-8");s.write(stringquickpvp[2]);s.close()