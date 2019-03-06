import re

date,version="",""
with open("Version.txt","r") as f:
    s=f.readlines()
    date=s[0][0:-1]
    version=s[1][0:-1]

masterfile=open("Game_Master/"+date+".txt",'r',encoding="UTF-8")
master=masterfile.readlines()
emerged=open("Merge/"+version+"emerged.txt","r",encoding="UTF-8")
eng=emerged.readlines()
merged=open("Merge/"+version+"merged.txt","r",encoding="UTF-8")
chi=merged.readlines()

coefi=["","","","","","","",""]
weather=[[],[]]
index=0
for i in range(0,len(master)):
    if("template_id: \"COMBAT_SETTINGS" in master[i]):
        i+=1
        coefi[6]+=("COMBAT_SETTINGS: \n")
        while("}" not in master[i]):
            if("{" not in master[i]):
                temp="";temp+=master[i]
                temp=temp.replace(' ','')
                position=temp.find(":")
                coefi[6]+=temp[0:position+1]+' '+temp[position+1:len(temp)+1]
            i+=1
        continue
    
    if("template_id: \"BATTLE_SETTINGS" in master[i]):
        i+=1
        coefi[7]+=("BATTLE_SETTINGS: \n")
        while("}" not in master[i]):
            if("{" not in master[i]):
                temp="";temp+=master[i]
                temp=temp.replace(' ','')
                position=temp.find(":")
                coefi[7]+=temp[0:position+1]+' '+temp[position+1:len(temp)+1]
            i+=1
        continue
    
    if("template_id: \"POKEMON_UPGRADE_SETTINGS" in master[i]):
        while("}" not in master[i]):
            x=re.search("candy_cost: [0-9]+",master[i])
            y=re.search("stardust_cost: [0-9]+", master[i])
            if(x):
                coefi[2]+=re.search("[0-9]+",x.group()).group()+'\n'
            if(y):
                coefi[3]+=re.search("[0-9]+",y.group()).group()+'\n'
            i+=1
        continue
        
    if("template_id: \"WEATHER_BONUS_SETTINGS" in master[i]):
        i+=1
        coefi[5]+=("WEATHER_BONUS_SETTINGS: \n")
        i+=2
        while("}" not in master[i]):
            temp="";temp+=master[i]
            temp=temp.replace(' ','')
            position=temp.find(":")
            coefi[5]+=temp[0:position+1]+' '+temp[position+1:len(temp)+1]
            i+=1
        continue
    if("template_id: \"PLAYER_LEVEL_SETTINGS" in master[i]):
        while("}" not in master[i]):
            if('required_experience:') in master[i]:
                coefi[1]+=master[i].replace('    required_experience: ','')
            if('cp_multiplier:') in master[i]:
                coefi[0]+=master[i].replace('    cp_multiplier: ','')
            if("max_egg_player_level" in master[i] or "max_encounter_player_level" in master[i] or "max_quest_encounter_player_level" in master[i]):
                temp="";temp+=master[i]
                temp=temp.replace(' ','')
                position=temp.find(":")
                coefi[4]+=temp[0:position+1]+' '+temp[position+1:len(temp)+1]
            i+=1
        i+=1
        continue
    
    
    x=re.search("template_id: \"WEATHER_AFFINITY_[A-Z]+",master[i])
    if(x):
        weatherr=x.group().replace('template_id: \"WEATHER_AFFINITY_','').lower()
        for y in range(index,len(chi)):
            if (("weather_"+weatherr )in chi[y]):
                weather[0].append(re.search("[\u4e00-\u9fa5]+",chi[y+1]).group())
                index=y; break
        powerup=[]
        while('}' not in master[i]):
            r=re.search('pokemon_type: POKEMON_TYPE_[A-Z]+',master[i])
            if(r):
                temp=r.group().replace("pokemon_type: ",'').lower()
                for y in range(0,len(chi)):
                    if(temp in chi[y]):
                        powerup.append(re.search("[\u4e00-\u9fa5]+",chi[y+1]).group())
                        break
            i+=1
        weather[1].append(powerup)
'''
print(coefi[4])
for i in range(0,len(weather[1])):
    print(weather[0][i],weather[1][i])
'''


dd='Coefficient/'
output=[dd+'1_cp_multiplier.txt',dd+'2_required_expeirence.txt',dd+'3_candy_cost.txt',dd+'4_stardust_cost.txt',dd+'5_allinone.txt',dd+'6_weather.txt']
for i in range(0,len(output)-1):
        xx=open(output[i],"w",encoding="UTF-8")
        xx.write(coefi[i])
        xx.close()
xx=open(output[len(output)-2],"w",encoding="UTF-8")
for i in range(4,8):
    xx.write(coefi[i]+'\n')
xx.close()
xx=open(output[len(output)-1],"w",encoding="UTF-8")
for i in range(0,len(weather[1])):
    xx.write(str(weather[0][i])+' ')
    for z in weather[1][i]:
        xx.write(z+' ')
    xx.write('\n')
xx.close()
