import re

date="20181215"
version="0.131.1"

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
        if (num in alola) or (num in [386,479,493]): 
            if("NORMAL" in master[i] or "ORIGIN" in master[i] ):i+=40;continue
        if(num != checknum ):check=1;
        if((num in[351,412,413,421,422,423,487,492])and (check)):check=0;checknum=num;i+=40;continue
        
        
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
                index=int(re.search("[0-9]+",master[i]).group())
                ok=1
                for z in range(0,len(move[1])):
                    if(index==move[1][z]):pokequickmove+=' '+move[0][z];ok=0
                if(ok):print('error!')
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
                index=int(re.search("[0-9]+",master[i]).group())
                for z in range(0,len(move[1])):
                    if(index==move[1][z]):pokechargemove+=' '+move[0][z];ok=0
                if(ok):print(num,index,'error!',master[y])
                appear=1
            if("item_templates" in master[y]):
                i=y
                if(appear):
                    pokechargemove+='\n'
                else:pokechargemove+=' \n'
                break

#mew
two=0
for y in range(remember,len(master)):
    name=re.search('quick_moves: [A-Z\_]+',master[y])
    index=re.search('quick_moves: [0-9]+',master[y])
    if(name):
        name=name.group().replace('quick_moves: ','')
        for z in range(0,len(move[0])):
            if(move[0][z]==name): mewq+=' '+move[2][z]
        two+=1
        if(two==2):mewq+='\n';two=0
    if(index):
        index=int(re.search("[0-9]+",master[i]).group())
        ok=1
        for z in range(0,len(move[1])):
            if(index==move[1][z]):
                mewq+=' '+move[0][z];ok=0;two+=1;
                if(two==2):mewq+='\n';two=0
        if(ok):print('error!')
    if("item_templates" in master[y]): mewq+=' \n'; break
two=0
for y in range(remember,len(master)):
    name=re.search('cinematic_moves: [A-Z\_]+',master[y])
    index=re.search('cinematic_moves: [0-9]+',master[y])
    if(name):
        name=name.group().replace('cinematic_moves: ','')
        have=0
        for z in range(0,len(move[0])):
            if(move[0][z]==name): 
                if(move[2][z] not in mewc):mewc+=' '+move[2][z];have=1;break
        if(have):two+=1
        if(two==6):mewc+='\n';two=0
    if(index):
        ok=1
        index=int(re.search("[0-9]+",master[i]).group())
        for z in range(0,len(move[1])):
            if(index==move[1][z]):
                mewc+=' '+move[0][z];ok=0;two+=1;
                if(two==6):mewc+='\n';two=0
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