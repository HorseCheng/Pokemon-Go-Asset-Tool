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

move=[[],[],[]] #0: move name #1: move number #2: chi name
pokequickmove=""
pokechargemove=""
mewq=''
mewc=''


alola=[19,20,26,27,28,37,38,50,51,52,53,74,75,76,88,89,103,105]

#move name
for i in range(0,len(master)):
    if("WEATHER_AFFINITY" in master[i]):break
    x=re.search("template_id: \"V[0-9]+_MOVE_",master[i])
    if(x):
        num=int(re.search("[0-9]+",master[i]).group())
        name=re.search('MOVE_[A-Z\_]+',master[i]).group()
        name=name.replace('MOVE_','')
        move[0].append(name);move[1].append(num)
check=1;checknum=0  
remember=0 
noww=0

for i in range(0,len(move[1])):
    #if(move[1][i]==303):move[2].append('酸液炸彈') #sometimes APK file still don't have the new move name
    if(move[1][i]==326):move[2].append('雷電牙');continue
    if(move[1][i]==327):move[2].append('冰凍牙');continue

    for e in range(noww,len(chi)):
        if('move_reroll_confirm_desc' in chi[i]):break
        if("move_name_" in chi[e] and str(move[1][i]) in chi[e]):
            move[2].append(re.search("[\u4e00-\u9fa5]+",chi[e+1]).group()) #Search for chinese word
            break

#pokemon move
for i in range(0,len(master)):
     if("camera_aerialace" in master[i]):break
     x=re.search("template_id: \"V[0-9]+_POKEMON", master[i])
     if x:
        num=re.search("[0-9]+",x.group())
        num=int(num.group())

        appear=0
        
       #find duplicated data
        if (num in alola) or (num in [25,150,386,479,493,646])or(num in [1,2,3,4,5,6,7,8,9,13,14,15,41,42,43,44,45,48,49,54,55,58,59,60,61,62,63,64,65,88,89,96,97,104,105,107,123,125,126,129,130,131,143,147,148,149,169,179,180,181,182,186,212,228,229,258,246,247,248,259,260,273,274,275,280,281,282,302,328,329,330,331,332,353,354,355,356,387,388,389,466,467,475,477]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        if(num != checknum ):check=1
        if((num in[351,412,413,421,422,423,487,492,550,555,585,586,641,642,645,647,648,649])and (check)):check=0;checknum=num;i+=40;continue
        
        if(num==151):remember=i;pokechargemove+=' \n';pokequickmove+=' \n';continue
        
        for y in range(i,len(master)):
            name=re.search('quick_moves: [A-Z\_]+',master[y])
            index=re.search('quick_moves: [0-9]+',master[y])
            if(name):
                name=name.group().replace('quick_moves: ','')
                for z in range(0,len(move[0])):
                    if(move[0][z]==name): pokequickmove+=' '+move[2][z]
                appear=1
            if(index):
                index=int(re.search("[0-9]+",master[y]).group())
                ok=1
                for z in range(0,len(move[1])):
                    if(index==move[1][z]):pokequickmove+=' '+move[2][z];ok=0
                if(ok):print(num,index,'error!',master[y])
                appear=1
            if("item_templates" in master[y]):
                if(check):
                    pokequickmove+='\n'
                else:pokequickmove+=' \n'
                break
        for y in range(i,len(master)):
            name=re.search('cinematic_moves: [A-Z\_]+',master[y])
            index=re.search('cinematic_moves: [0-9]+',master[y])
            if(name):
                name=name.group().replace('cinematic_moves: ','')
                for z in range(0,len(move[0])):
                    if(move[0][z]==name): pokechargemove+=' '+move[2][z]
                appear=1
            if(index):
                
                ok=1
                index=int(re.search("[0-9]+",master[y]).group())
                for z in range(0,len(move[1])):
                    if(index==move[1][z]):pokechargemove+=' '+move[2][z];ok=0
                if(ok):print(num,index,'error!',master[y])
                appear=1
            if("item_templates" in master[y]):
                i=y
                if(appear):
                    pokechargemove+='\n'
                else:pokechargemove+=' \n'
                break

#mew
four=0
for y in range(remember,len(master)):
    name=re.search('quick_moves: [A-Z\_]+',master[y])
    index=re.search('quick_moves: [0-9]+',master[y])
    if(name):
        name=name.group().replace('quick_moves: ','')
        for z in range(0,len(move[0])):
            if(move[0][z]==name): mewq+=' '+move[2][z];four+=1;break;
    if(index):
        index=int(re.search("[0-9]+",master[y]).group())
        ok=1
        for z in range(0,len(move[1])):
            if(index==move[1][z]):
                mewq+=' '+move[2][z];ok=0;four+=1;break
        if(ok):print('error!')
    if(four==4):mewq+='\n';four=0
    if("item_templates" in master[y]): mewq+=' \n'; break
three=0
for y in range(remember,len(master)):
    name=re.search('cinematic_moves: [A-Z\_]+',master[y])
    index=re.search('cinematic_moves: [0-9]+',master[y])
    if(name):
        name=name.group().replace('cinematic_moves: ','')
        have=0
        for z in range(0,len(move[0])):
            if(move[0][z]==name): 
                if(move[2][z] not in mewc):mewc+=' '+move[2][z];have=1;break
        if(have):three+=1
        if(three==6):mewc+='\n';three=0
    if(index):
        ok=1
        index=int(re.search("[0-9]+",master[y]).group())
        for z in range(0,len(move[1])):
            if(index==move[1][z]):
                mewc+=' '+move[2][z];ok=0;three+=1;
                if(three==6):mewc+='\n';three=0
        if(ok):print(num,index,'error!',master[y])
    if("item_templates" in master[y]): mewc+='\n';break

pokechargemove=pokechargemove[:-1]; mewc=mewc[:-1]
pokequickmove=pokequickmove[:-1];   mewq=mewq[:-1]
aa=open("move/pokequickmove.txt","w",encoding="UTF-8")
bb=open("move/pokechargemove.txt","w",encoding="UTF-8")
cc=open("move/mewcharge.txt","w",encoding="UTF-8")
dd=open("move/mewquick.txt","w",encoding="UTF-8")
aa.write(pokequickmove);aa.close()
bb.write(pokechargemove);bb.close()
cc.write(mewc);cc.close()
dd.write(mewq);dd.close()