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
weatherformfile=open("Coefficient/6_weather.txt",'r',encoding="UTF-8")
weatherform=weatherformfile.readlines()

for x in range(len(chi)): #find chinese name for type name
    if("pokemon_type_" in chi[x]):Key=x;break;


alola=[19,20,26,27,28,37,38,50,51,52,53,74,75,76,88,89,103,105]

indexlist=[]
pokedata=[]
typee=["","","",""]#type one,type two, weather boost one, weather boost two
intro=[[],[],[],[]]#chi name, eng name, chi type, chi intro,
check=1;checknum=0
#gender=[0,0,0]
pokecheck=[0 for c in range(0,1000)] #pokemon different type count

def set(index,inn):
    checkmatrix[inn]=1
    temp=re.search("[0-9\.]+",master[index]).group()
    if(inn==0 or inn==1):
        if(temp=='100'):string[inn]+='1'
        else: string [inn]+=temp
    else:string[inn]+=temp

for i in range(0,len(master)):
    if("camera_aerialace" in master[i]):break
    x=re.search("template_id: \"V[0-9]+_POKEMON", master[i])
    if x:
        num=int(re.search("[0-9]+",master[i]).group())

        checkmatrix=[0 for c in range(0,14)]
        
        #find duplicated data
        if (num in alola) or (num in [150,386,479,493])or(num in [1,2,3,4,5,6,7,8,9,41,42,60,61,62,88,89,96,97.104,105,123,129,130,143,147,148,149,169,186,212,228,229,258,259,260,280,281,282,475]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        if(num != checknum ):check=1
        if((num in[351,412,413,421,422,423,487,492])and (check)):check=0;checknum=num;i+=40;continue

        #start record pokemon data
        pokecheck[num]+=1
        if(pokecheck[num]==1):indexlist.append(num)
        else:indexlist.append('')
        justone=1 #evolution might have several types, each has "candy_cost"
        string = ["" for x in range(14)];typee=["","","",""] 
        for y in range(i,len(master)):
            if("type: POKEMON_TYPE_" in master[y]):
                temp="";position=master[y].find(":")
                for tt in range(position+2,len(master[y])-1):
                     temp+=(str(master[y][tt].lower())) #type english name
                for z in range(Key,len(chi)):
                    if (temp in chi[z]):
                        type1=re.search("[\u4e00-\u9fa5]+",chi[z+1]).group()#find chinese name
                        typee[0]+=type1
                        for w in range(len(weatherform)):
                            if(type1 in weatherform[w]):
                                typee[2]+=re.search("[\u4e00-\u9fa5]+|$",weatherform[w]).group()#find chinese name for weather
                        break
                continue
            if("type_2: POKEMON_TYPE_" in master[y]):
                position=master[y].find(":")
                temp=""
                for tt in range(position+2,len(master[y])-1):
                     temp+=(str(master[y][tt].lower()))
                for z in range(Key,len(chi)):
                    if (temp in chi[z]):
                        type2=re.search("[\u4e00-\u9fa5]+",chi[z+1]).group()
                        typee[1]+=type2
                        for w in range(len(weatherform)):
                            if(type2 in weatherform[w]):
                                temp=re.search("[\u4e00-\u9fa5]+|$",weatherform[w]).group() 
                                if(temp not in typee[2]):
                                    typee[3]+=temp
                        break
                continue
            if("collision_radius_m: " in master[y]): set(y,12);continue
            if("collision_height_m: " in master[y]): set(y,13);continue
            if("base_capture_rate: " in master[y]): set(y,0);continue
            if("base_flee_rate: " in master[y]): set(y,1);continue
            if("camera_distance: " in master[y]): set(y,11);continue
            if("base_stamina: " in master[y]): set(y,4);continue
            if("base_attack: " in master[y]): set(y,2);continue
            if("base_defense: " in master[y]): set(y,3);continue
            if("pokedex_height_m: " in master[y]): set(y,5);continue
            if("pokedex_weight_kg:" in master[y]): set(y,6);continue
            if("km_buddy_distance: " in master[y]): set(y,10);continue
            if("candy_cost: " in master[y] and justone): justone=0;set(y,7);continue
            if("third_move" in master[y]): 
                if "candy_to_unlock" in master[y+1]:set(y+1,9);continue
                else:set(y+1,8);set(y+2,9);continue
            if("item_templates" in master[y]):
                string.insert(0,typee[3]);string.insert(0,typee[2]);string.insert(0,typee[1]);string.insert(0,typee[0]);
                pokedata.append(string)
                break      

#gender ratio
genderstr=[]
okk=0
for i in range(0,len(master)):
    if("V0001_POKEMON" in master[i] ):
        okk=okk+1
        if(okk==9):break
    x=re.search("template_id: \"SPAWN_V[0-9]+_POKEMON_",master[i])
    if x:
        num=int(re.search("[0-9]+",master[i]).group())
        
         #find duplicated data
        if (num in alola) or (num in [386,479,493])or(num in [1,2,3,4,5,6,7,8,9,41,42,60,61,62,88,89,96,97.104,105,123,129,130,143,147,148,149,169,186,212,228,229,258,259,260,280,281,282,475]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        if(num != checknum ):check=1
        if((num in[351,412,413,421,422,423,487,492])and (check)):check=0;checknum=num;i+=40;continue
        
        gender=[0,0,0] #male,female,non gender
        for tt in range(i,len(master)):
             if("genderless_percent" in master[tt]):gender[2]=1;break
             if('female_percent' in master[tt]):gender[1]=re.search("[0-9\.]+",master[tt]).group();continue
             if('male_percent' in master[tt]):gender[0]=re.search("[0-9\.]+",master[tt]).group()
             if("}" in master[tt]):i=tt;break
        if(float(gender[2])):genderstr.append('無性別') #No Gender
        elif (float(gender[0]) and float(gender[1])): genderstr.append(str(gender[0]))
        elif(float(gender[0])==0): genderstr.append('全女性') #All Female
        elif(float(gender[1])==0): genderstr.append('全男性') #All Male

#pokemon intro
startt=0;temp="";num=0;tempAlola=""
def finding(language,line):
    global num,temp,tempAlola
    num=int(re.search("[0-9]+",globals()[language][line]).group())
    temp=re.search("\"[^\"]+",globals()[language][line+1]) #find descrpition
    temp=temp.group().replace("\"","") if temp else ""
    if(num in alola):#Alola type has seperate description
        temp2=re.search("\"[^\"]+",globals()[language][line+5]) #find descrpition
        tempAlola=temp2.group().replace("\"","") if temp2 else "" 

        
for e in range(0,len(chi)): #pokemon introducing type
    if "pokemon_desc" in chi[e]:startt=e;break
    if("pokemon_category" in chi[e] and '0000' not in chi[e]):
        finding('chi',e)
        for tt in range(0,pokecheck[num]):#only print once, special type don't need to print
            if(tt==0): intro[2].append(temp)
            else:intro[2].append('')
    
duplicated=0#avoid duplicated line when searching the alola pokemon
for e in range(startt,len(chi)):#pokemon introducing description
    if "pokemon_evolution_tap_to_evolve" in chi[e]:startt=e;break
    if("pokemon_desc" in chi[e] and '0000' not in chi[e]):
        finding('chi',e)
        if(duplicated!=1):
            for tt in range(0,pokecheck[num]):#only print once, special type don't need to print
                if(tt==0): intro[3].append(temp)
                elif(num in alola):duplicated=1;intro[3].append(tempAlola)#second line for Alola
                else:intro[3].append('')
        else:duplicated=0
    
for e in range(startt,len(chi)):#pokemon name
    if "pokemon_nickname_error" in eng[e]:break
    if("pokemon_name" in eng[e] and '0000' not in eng[e]):
        finding('eng',e)
        for tt in range(0,pokecheck[num]):#only print once
            intro[1].append(temp)
    if("pokemon_name_" in chi[e] and '0000' not in chi[e]):
        finding('chi',e)
        for tt in range(0,pokecheck[num]):#only print once
            intro[0].append(temp)

#for i in range(len(intro[2])):
#   print(intro[2][i],intro[3][i])
    
#list to string
wholestring="" #data string to output
for i in range(0,len(pokedata)):
    wholestring+='c '
    for x in pokedata[i]:
        wholestring+=x+' '
    wholestring+=genderstr[i]+'\n'

namestring="" #chinese name string to output
for i in range(0,len(indexlist)):
    namestring+='c '+str(indexlist[i])+' '+intro[0][i]+'\n'
    
    
descpritionstring=""
for i in range(0,len(indexlist)):
    descpritionstring+='c '+intro[2][i]+' '+intro[3][i]+'\n'

#output data
aa=open("Pokemon Data/1_chiname.txt","w",encoding="UTF-8")
bb=open("Pokemon Data/2_engname.txt","w",encoding="UTF-8")
cc=open("Pokemon Data/3_database.txt","w",encoding="UTF-8")
dd=open("Pokemon Data/4_description.txt","w",encoding="UTF-8")
aa.write(namestring);cc.write(wholestring);dd.write(descpritionstring)
aa.close();cc.close();dd.close()

for i in intro[1]:
    bb.write(i+'\n')
bb.close()