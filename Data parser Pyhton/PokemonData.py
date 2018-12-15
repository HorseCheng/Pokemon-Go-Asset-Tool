import re

date="20181215"
version="0.131.1"

emerged=open("Merge/"+version+"emerged.txt","r",encoding="UTF-8")
eng=emerged.readlines()
merged=open("Merge/"+version+"merged.txt","r",encoding="UTF-8")
chi=merged.readlines()
masterfile=open("Game_Master/"+date+".txt",'r',encoding="UTF-8")
master=masterfile.readlines()

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

alola=[19,20,26,27,28,37,38,50,51,52,53,74,75,76,88,89,103,105]

'''
f=open("20181215.txt",'r',encoding="UTF-8")
a=f.readlines()
ff=open("1208emerged.txt","r",encoding="UTF-8") #10000-14000
b=ff.readlines()
fff=open("1208merged.txt","r",encoding="UTF-8") #11000-14000,7000-9000,9000-11000
c=fff.readlines()
'''
i=0
string = ["" for x in range(11)]
typee=["",""]
intro=["","","",""]#eng name, chi name, chi type, chi intro,
check=1;checknum=0
gender=[0,0,0]
pokecheck=[[0 for c in range(0,1000)],[0 for c in range(0,1000)]] #checkbit, cnt


def set(index,inn):
    checkmatrix[inn]=1
    position=master[index].find(": ")
    for ind in range(position+1,len(master[index])):
        string[inn]+=master[index][ind]

for i in range(0,len(master)):
    if("camera_aerialace" in master[i]):break
    x=re.search("template_id: \"V[0-9]+_POKEMON", master[i])
    if x:
        num=re.search("[0-9]+",x.group())
        num=int(num.group())

        checkmatrix=[0 for c in range(0,11)]
        typecheck=[0,0]
        tttt=1
        
        if (num in alola) or (num in [386,479,493]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        
        if((num in[351,412,413,421,422,423,487,492])and (check)):check=0;checknum=num;i+=40;continue
        if(num != checknum ):check=1
        pokecheck[1][num]+=1
        
        for y in range(i,len(master)):
            if("type: POKEMON_TYPE_" in master[y]):
                i=y;typecheck[0]=1
                position=master[i].find(":")
                temp=""
                for tt in range(position+2,len(master[i])-1):
                     temp+=(str(master[i][tt].lower()))
                for z in range(0,len(Key)):
                    if (temp in Key[z]):
                        typee[0]+=re.search("[\u4e00-\u9fa5]+",Key[z+1]).group()+'\n'
                continue
            if("type_2: POKEMON_TYPE_" in master[y]):
                i=y;typecheck[1]=1
                position=master[i].find(":")
                temp=""
                for tt in range(position+2,len(master[i])-1):
                     temp+=(str(master[i][tt].lower()))
                for z in range(0,len(Key)):
                    if (temp in Key[z]):
                        typee[1]+=re.search("[\u4e00-\u9fa5]+",Key[z+1]).group()+'\n'
                continue
            if("disk_radius_m" in master[y]):
                i=y;set(i,10)
                continue
            if("base_capture_rate: " in master[y]):
                ttemp=""
                i=y;checkmatrix[0]=1;
                position=master[i].find(": ")
                for ind in range(position+1,len(master[i])):
                    ttemp+=master[i][ind]
                if(ttemp==" 100\n"):string[0]+='1\n'
                else:string[0]+=ttemp
                continue
            if("base_flee_rate: " in master[y]):
                i=y;checkmatrix[1]=1
                position=master[i].find(": ")
                for ind in range(position+1,len(master[i])):
                    string[1]+=master[i][ind]
                continue
            if("camera_distance: " in master[y]):
                i=y;checkmatrix[9]=1
                position=master[i].find(": ")
                for ind in range(position+1,len(master[i])):
                    string[9]+=master[i][ind]
                continue
            if("base_stamina: " in master[y]):
                i=y;set(i,4)
                continue
            if("base_attack: " in master[y]):
                i=y;set(i,2)
                continue
            if("base_defense: " in master[y]):
                i=y;set(i,3)
                continue
            if("pokedex_height_m" in master[y]):
                i=y;set(i,5)
                continue
            if("pokedex_weight_kg:" in master[y]):
                i=y;set(i,6)
                continue
            if("km_buddy_distance" in master[y]):
                i=y;set(i,8);
                continue
            if("candy_cost" in master[y] and tttt):
                i=y;tttt=0;set(i,7)
                continue
            if("item_templates" in master[y]):
                i=y
                for t in range(0,len(checkmatrix)):
                    if (checkmatrix[t]==0):string[t]+='\n'
                if(typecheck[0]==0):typee[0]+='\n'
                if(typecheck[1]==0):typee[1]+='\n'
                break      

startt=0
for e in range(0,len(chi)):
    if "pokemon_desc" in chi[e]:startt=e;break
    
    if("pokemon_category" in chi[e] and '0000' not in chi[e]):
        num=re.search("[0-9]+",chi[e]);num=int(num.group())
        temp=""
        position=chi[e+1].find("\"")
        for x in range(position+1,len(chi[e+1])-2):
             temp+=chi[e+1][x]
        for tt in range(0,pokecheck[1][num]):
            if(tt==0):intro[2]+=(temp+'\n')
            else:intro[2]+='\n'

for e in range(startt,len(chi)):
    if "pokemon_evolution_tap_to_evolve" in chi[e]:startt=e;break
    
    if("pokemon_desc" in chi[e] and '0000' not in chi[e]):
        num=re.search("[0-9]+",chi[e]);num=int(num.group())
        temp=""
        position=chi[e+1].find("\"")
        for x in range(position+1,len(chi[e+1])-2):
             temp+=chi[e+1][x]
        for tt in range(0,pokecheck[1][num]):
            if(tt==0):intro[3]+=(temp+'\n')
            else:intro[3]+='\n'
            
            
for e in range(startt,len(eng)):
    if "pokemon_nickname_error" in eng[e]:break

    if("pokemon_name" in eng[e] and '0000' not in eng[e]):
        num=re.search("[0-9]+",eng[e]);num=int(num.group())
        position=eng[e+1].find("\"")
        temp=""
        for x in range(position+1,len(eng[e+1])-2):
            temp+=eng[e+1][x]
        for tt in range(0,pokecheck[1][num]):
            intro[0]+=(temp+'\n')
        if(pokecheck[1][num]==0):intro[0]+='\n'
    if("pokemon_name_" in chi[e] and '0000' not in chi[e]):
        num=re.search("[0-9]+",chi[e]);num=int(num.group())
        temp=""
        for x in range(position+1,len(chi[e+1])-2):
            temp+=chi[e+1][x]
        for tt in range(0,pokecheck[1][num]):
            intro[1]+=(temp+'\n')
        if(pokecheck[1][num]==0):intro[1]+='\n'

genderstr=""

okk=0
for i in range(0,len(master)):
    if("V0001_POKEMON" in master[i] ):
        okk=okk+1
        if(okk==3):break

    x=re.search("template_id: \"SPAWN_V[0-9]+_POKEMON_",master[i])
    if x:
        num=re.search("[0-9]+",master[i]);num=int(num.group())
        if (num in alola) or (num in [386,479,493]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        if((num in[351,412,413,421,422,423,487,492])and (check)):check=0;checknum=num;i+=40;continue
        if(num != checknum ):check=1
        
        gender=[0,0,0];i+=4#male,female,non gender
        for tt in range(i,len(master)):
             if("genderless_percent" in master[tt]):gender[2]=1;break
             if('female_percent' in master[tt]):gender[1]=re.search("[0-9\.]+",master[tt]).group();continue
             if('male_percent' in master[tt]):gender[0]=re.search("[0-9\.]+",master[tt]).group()
             if("}" in master[tt]):i=tt;break
        if(float(gender[2])):genderstr+='無性別\n' #No Gender
        elif (float(gender[0]) and float(gender[1])): genderstr +=str(gender[0])+'\n'
        elif(float(gender[0])==0): genderstr+='全女性\n' #All femal
        elif(float(gender[1])==0): genderstr+='全男性\n' #All Male

dd='mul/' 
cnt=0;
newstring="c "
acc = [0 for x in range(11)]
for i in range(0,len(string[5])):
    if(string[5][i]=='\n'):cnt=cnt+1
for i in range(0,11):
    string[i]=string[i].replace(' ','')
while(True):
    if(cnt==0):break
    for i in range(0,11):
        for x in range(acc[i],10000000):
            if(string[i][x]=='\n'):
                #if(x==acc[i]):newstring=newstring+' '
                acc[i]=x+1;break
            newstring+=string[i][x]
        newstring=newstring+' '
        if(i==6):newstring=newstring+' '
    cnt=cnt-1
    if(cnt !=0):newstring=newstring+'\nc '
    

cc=open(dd+'/4_allinone.txt',"w",encoding="UTF-8")
cc.write(newstring);cc.close()

output=[dd+'2_pokeeng.txt',dd+'1_pokechi.txt',dd+'17_poketype.txt',dd+'18_pokeintro.txt']
for i in range(0,len(intro)):
        xx=open(output[i],"w",encoding="UTF-8")
        xx.write(intro[i])
        xx.close()
aa=open(dd+"/15_typeone.txt","w",encoding="UTF-8")
bb=open(dd+"16_tyoetwo.txt","w",encoding="UTF-8")
cc=open(dd+"10_gender.txt","w",encoding="UTF-8")
aa.write(typee[0]);aa.close()
bb.write(typee[1]);bb.close()
cc.write(genderstr);cc.close()


'''
dd='mul/'
output=[dd+'3_capture.txt',dd+'4_flee.txt',dd+'13_camera.txt',dd+'7_s.txt',dd+'5_a.txt',dd+'6_d.txt',dd+'8_height.txt'\
        ,dd+'9_weight.txt',dd+'14_radius.txt',dd+'12_buddy.txt',dd+'11_evo.txt']
for i in range(0,len(output)):
        xx=open(output[i],"w",encoding="UTF-8")
        xx.write(string[i])
        xx.close()
'''
