import re

date="20181215"

masterfile=open("Game_Master/"+date+".txt", "r" ,encoding="UTF-8")
master=masterfile.readlines()

order= ['NORMAL', 'FIGHTING', 'FLYING', 'POISON', 'GROUND', 'ROCK', 'BUG', 'GHOST', 'STEEL', 'FIRE', 'WATER', 'GRASS', 'ELECTRIC', 'PSYCHIC', 'ICE', 'DRAGON', 'DARK', 'FAIRY']
#attack_scalar order

counter={} #save the attack_scalar of each type
for i in range(0,len(master)):
    if('POKEMON_UPGRADE_SETTINGS' in master[i]):break
    x=re.search("template_id: \"POKEMON_TYPE_[A-Z]+",master[i])
    if(x):
        x=x.group().replace("template_id: \"POKEMON_TYPE_","") #parse the type name
        temp=[]
        for y in range(i+2,i+20):
            temp.append(re.search("[0-9\.]+",master[y]).group()) #parse attack_scaler
        counter[x]=temp #save to the counter dict.
        i=y

 
output="" #parse dictionary to string 
for i in order:
    for scaler in counter[i]:
        output+=scaler+' '
    output+='\n'

#output data
aa=open("Coefficient/Counter.txt","w",encoding="UTF-8")
aa.write(output);aa.close()