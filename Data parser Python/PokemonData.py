import re
import json
import pandas as pd
date, version = "", ""
with open("Version.txt", "r") as f:
    s = f.readlines()
    date = s[0][0:-1]
    version = s[1][0:-1]
print(date, version)

with open("Merge/" + version + "english.json") as f:
    eng = json.load(f)
eng = eng ["data"]

with open("Merge/" + version + "chinesetraditional.json") as f:
    chi = json.load(f)
chi = chi ["data"]

with open("Game_Master/" + date + ".json") as f:
    master = json.load(f)
master=master ["itemTemplate"]

typeeform = open("Coefficient/Type.txt", "r", encoding="UTF-8")
weatherform = open("Coefficient/Weather.txt", "r", encoding="UTF-8")

#Preprocess
typee={}
for line in typeeform:
   (key, val) = line.split()
   typee[key] = val 

weather={}
for line in weatherform:
   (key, *val) = line.split()
   weather[key] = val

catdict={}; introdict={}
for value,char in enumerate(chi):
    x=re.search("pokemon_desc_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+[_0-9]+",char).group()
        if("_"in key):key=key.split("_")[0]+"_1"
        introdict[key]=chi[value+1]
    x=re.search("pokemon_category_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+",char).group()
        catdict[key]=chi[value+1]

chinamedict={}
for value,char in enumerate(chi):
    x=re.search("pokemon_name_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+",char).group()
        chinamedict[key]=chi[value+1]
engnamedict={}
for value,char in enumerate(eng):
    x=re.search("pokemon_name_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+",char).group()
        engnamedict[key]=eng[value+1]

#New Pokemon
chinamedict["0862"] = "堵攔熊"
engnamedict["0862"] = "Obstagoon"
chinamedict["0863"] = "喵頭目"
engnamedict["0863"] = "Perrserker"
chinamedict["0865"] = "葱游兵"
engnamedict["0865"] = "Sirfetch'd"
       
chimovedict={}
for value,char in enumerate(chi):
    x=re.search("move_name_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+",char).group()
        chimovedict[key]=chi[value+1]
engmovedict={}
for value,char in enumerate(eng):
    x=re.search("move_name_[0-9]+", char)
    if(x):
        key=re.search("[0-9]+",char).group()
        engmovedict[key]=eng[value+1]

class pokemon():
    def __init__(self, inn):
     settings=inn["pokemon"]
     self.id = re.search("V[0-9]+",inn['templateId']).group().strip("V")
     self.name = re.search("POKEMON_\S+",inn['templateId']).group().replace("POKEMON_","")
     self.chi = chinamedict[self.id]
     self.eng = engnamedict[self.id]
     self.type = self.typehandle(settings["type1"])
     self.type2 = self.typehandle(settings.get("type2",""))
     self.weather1= ""
     self.weather2= self.weatherhandle()
     self.capture = self.capturehandle(settings["encounter"].get("baseCaptureRate","")) 
     self.flee = settings["encounter"].get("baseFleeRate","")
     self.atk = settings["stats"]["baseAttack"]
     self.deff= settings["stats"]["baseDefense"]
     self.hp= settings["stats"]["baseStamina"]
     self.height= settings["pokedexHeightM"]
     self.weight= settings["pokedexWeightKg"]
     self.candy= self.candyhandle(settings.get("evolutionBranch",""))
     self.thirdstardust= settings["thirdMove"].get("stardustToUnlock","")
     self.thirdcandy= settings["thirdMove"].get("candyToUnlock","")
     self.buddy= settings["kmBuddyDistance"]
     self.camdist= settings["encounter"]["cameraDistance"]
     self.camrad= settings["encounter"]["collisionRadiusM"]
     self.camheight= settings["encounter"]["collisionHeightM"]
     self.ratio=""
     self.desccat=self.descripthandle("cat")
     self.descintro=self.descripthandle("intro")
     self.quick=settings.get("quickMoves")
     self.charged=settings.get("cinematicMoves")
    
    def typehandle(self, inn):
     if(inn==""): return ""
     return typee[inn]

    def weatherhandle(self):
     for name,value in weather.items():
         if(self.type in value): self.weather1= name
     if(self.type2==""): return ""
     for name,value in weather.items():
         if(self.type2 in value and name != self.weather1 ): return name
     return ""
 
    def capturehandle(self, inn):
     return 1 if inn==100 else inn
    
    def candyhandle(self, inn):
     if(type(inn)==list): return inn[0]["candyCost"]
     return ""
     
    def descripthandle(self, typee):
        if(typee=="cat"):
           try: return catdict[self.id]
           except: return ""
        if("ALOLA" in self.name or "GALARIAN" in self.name):
            try: return introdict[self.id+"_1"]
            except: 
                try: return introdict[self.id]
                except: return ""
        try: return introdict[self.id]
        except: return ""
    
    def ratiohandle(self, inn):
        if(inn.get("malePercent","")==1): self.ratio="全男性" 
        elif(inn.get("femalePercent","")==1): self.ratio="全女性"
        elif(inn.get("genderlessPercent","")==1): self.ratio="無性別"
        else: self.ratio=inn["malePercent"]

class move():
    def __init__(self, inn):
      settings=inn["move"]
      self.id = re.search("V[0-9]+",inn['templateId']).group().strip("V")
      self.name =  settings.get("movementId")
      self.chi = chimovedict[self.id]
      self.eng = engmovedict[self.id]
      self.quick = True if 'FAST' in inn['templateId'] else False
      self.type = self.typehandle(settings['pokemonType'])
      self.power= settings.get("power","")
      self.energy= self.energyhandle(settings.get("energyDelta",""))
      self.times= settings.get("durationMs","")
      self.start= settings.get("damageWindowStartMs","")
      self.powerpvp= ""
      self.energypvp= ""
      self.turnpvp= ""
      self.buffchance=""
      self.buff=""
      
    def typehandle(self, inn):
        if(inn==""): return ""
        return typee[inn]
 
    def energyhandle(self, inn):
        if inn=="": return ""
        if inn < 0:return inn
        return "+"+ str(inn)
    
    def pvphandle(self, inn):
        self.powerpvp= inn.get("power","")
        self.energypvp= self.energyhandle(inn.get("energyDelta",""))
        
        if(inn.get("buffs","")!= ""):
            buffdebuff="加"; who="己方"; atkdef=""; number=" 1 層"
            for value,char in enumerate(inn["buffs"]):
                if(value==0):
                    if(inn["buffs"][char]<0):buffdebuff="降"
                    if(abs(inn["buffs"][char])==2):  number=" 2 層"
                if("target" in char):who="對方"
                if("Attack" in char): atkdef+="攻擊"
                if("Defense" in char): atkdef+="防禦"
            if(len(atkdef)==4): atkdef="攻擊和防禦"
            self.buff= who+atkdef+number
            chance=inn["buffs"]["buffActivationChance"]*100
            if(chance-int(chance)==0):
                chance=int(chance) #float to int
            self.buffchance=str(chance)+"% "+buffdebuff
        
        if(self.quick==False): return
        tempturn=inn.get("durationTurns","")
        if tempturn=="": self.turnpvp=1
        else: self.turnpvp = int(tempturn)+1
        
#Rearrange poke1 to the row after poke2
def rearrange(dataframe,poke1, poke2):
    x=dataframe.loc[dataframe['name'].str.contains(poke1)]
    dataframe.drop(dataframe[dataframe['name'].str.contains(poke1)].index, axis=0, inplace=True)
    y=dataframe.index[dataframe['name'].str.contains(poke2)][0]
    dataframe = pd.concat([dataframe.iloc[:y], x, dataframe.iloc[y:]]).reset_index(drop=True)
    return dataframe

#Create Pokemon/Move(from PVE data) Class
pokelist=[]; movelist=[]
maxquick=0; maxcharged=0

for data in master:
    if(re.search("^V[0-9]+_POKEMON_",data["templateId"])):
        pokelist.append(pokemon(data))
        if(pokelist[-1].quick != None and len(pokelist[-1].quick) > maxquick and pokelist[-1].name!='MEW'): maxquick=len(pokelist[-1].quick)
        if(pokelist[-1].charged != None and len(pokelist[-1].charged) > maxcharged and pokelist[-1].name!='MEW'): maxcharged=len(pokelist[-1].charged)
        #except:print(data)
        
    if(re.search("^V[0-9]+_MOVE_",data["templateId"])):
        movelist.append(move(data))
        
#Find male/female ratio     
noww=-1
for data in master:
    if(re.search("SPAWN_V[0-9]+_POKEMON_", data["templateId"])):
        for i in range(noww+1, len(pokelist)):
            if(pokelist[i].name in data["templateId"]):
                pokelist[i].ratiohandle(data["genderSettings"]["gender"])
                noww=i; break
        else:print("ratio error",data["templateId"]) #Didn't found, weird situation
        
#PVP Moves Info
noww=-1
for data in master:
    if(re.search("COMBAT_V[0-9]+_MOVE_", data["templateId"])):
        for i in range(noww+1, len(movelist)):
            if str(movelist[i].name) in data["templateId"]:
                movelist[i].pvphandle(data["combatMove"])
                noww=i; break
        else:print("pvp error", data["templateId"]) #Didn't found, weird situation

#Special condition: make DEOXYS's moves the same as DEOXYS_NOMARL's
for x in pokelist:
    if x.name== 'DEOXYS':
        for y in pokelist:
            if y.name== 'DEOXYS_NORMAL':
                x.quick=y.quick; x.charged=y.charged
                break
        break
    
#Pokemon Moves Translation
for i in pokelist:
    if i.quick != None:   
        for value,char in enumerate(i.quick):
            for z in movelist:
                if z.name==char:
                    i.quick[value]=z.chi
    if i.quick != None:
        for value,char in enumerate(i.charged):
            for z in movelist:
                if z.name==char:
                    i.charged[value]=z.chi

#for i in pokelist:
#    print(i.quick)   

#Output file
origin=pd.DataFrame([i.__dict__ for i in pokelist])

# =============================================================================
# Main Pokemon List
# =============================================================================
main=origin[ ~origin['name'].str.contains('NORMAL|BURMY$|WORMADAM$|CHERRIM$|SHELLOS$|GASTRODON$|GIRATINA$|SHAYMIN$|BASCULIN$|DARMANITAN$|DEERLING$|SAWSBUCK$|TORNADUS$|THUNDURUS$|LANDORUS$|KELDEO$|MELOETTA$|SHADOW|PURIFIED') ].reset_index(drop=True)
main=main.sort_values(by=['id'],kind='mergesort')

#Rearange for DEERLING AUTUMN
main=rearrange(main, 'DEERLING_AUTUMN', 'DEERLING_SUMMER' )
main=rearrange(main, 'SAWSBUCK_AUTUMN', 'SAWSBUCK_SUMMER' )

maindb=main.drop(["id","name","chi","eng","quick","charged"], axis=1)
mainheader=main[["id","name","chi","eng"]]
maindb.to_csv('Pokemon Data/Pokemondb.csv' , encoding='utf_8_sig', header=False, index=False)
mainheader.to_csv('Pokemon Data/Pokemonheader.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# Shadow Pokemon List
# =============================================================================
shadow=origin[ origin['name'].str.contains('SHADOW|PURIFIED') ]
shadow=shadow.drop(["name","quick","charged","desccat","descintro"], axis=1)
shadow.insert(3, "Form","",True) 
shadow["Form"] = "暗影型態"
shadow.loc[1::2,"Form"] = "淨化型態"
shadow=shadow.sort_values(by=['id'],kind='mergesort')
shadow.to_csv('Pokemon Data/Shadows.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# #Pokemon Move
# =============================================================================
#Move MEW to last line and Segment Mew
pokename=main[["id","name","chi","eng"]]
quickmove=main["quick"].tolist()
chargedmove=main["charged"].tolist()

mewindex=pokename[pokename['name'] =='MEW'].index[0]
mewquick=quickmove[mewindex]
mewcharged=chargedmove[mewindex]
mewcharged=list(set(mewcharged))
mewline=pokename.iloc[mewindex]
del quickmove[mewindex], chargedmove[mewindex]
pokename=pokename.drop(mewindex).append(mewline)

print(f"#max quick: {maxquick}, #max charged: {maxcharged}")
temp=[mewquick[x:x+maxquick] for x in range(0, len(mewquick),maxquick)]
quickmove.extend(temp)
temp=[mewcharged[x:x+maxcharged] for x in range(0, len(mewcharged),maxcharged)]
chargedmove.extend(temp)

x=pd.Series(quickmove).apply(pd.Series)
y=pd.Series(chargedmove).apply(pd.Series)
lenx=len(x);leny=len(y);lenpoke=len(pokename)
for _ in range(leny-lenx):
    x=x.append(pd.Series(), ignore_index=True)
for _ in range(leny-lenpoke):
    pokename=pokename.append(pokename.iloc[-1], ignore_index=True)   
a=[i for i in range(leny)]
y['test']=a; x['test']=a; pokename['test']=a

pokemove=pokename.merge(x,on='test').merge(y,on='test').drop('test',axis=1)
pokemoveheader=pokemove[["id","name","chi","eng"]]
pokemovedb=pokemove.drop(["id","name","chi","eng"], axis=1)
pokemoveheader.to_csv('Pokemon Data/Pokemoveheader.csv' , encoding='utf_8_sig', header=False, index=False)
pokemovedb.to_csv('Pokemon Data/Pokemovedb.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# #Moves Info
# =============================================================================
quickdb=[]; chargeddb=[]
moveorigin=[i.__dict__ for i in movelist]
for i in moveorigin:
    if i["quick"]== True:
        quickdb.append(i)
    else: chargeddb.append(i)
quickdb=pd.DataFrame(quickdb).drop(["name","quick","buff","buffchance"],axis=1)
chargeddb=pd.DataFrame(chargeddb).drop(["name","quick","turnpvp"],axis=1)

quickdb.insert(8, "split",['' for i in range(len(quickdb))])
quickdb.insert(quickdb.shape[1], "split2",['' for i in range(len(quickdb))])

chargeddb.insert(8, "split",['' for i in range(chargeddb.shape[0])])
chargeddb.insert(11, "split2",['' for i in range(len(chargeddb))])

for _ in range(len(chargeddb)-len(quickdb)):
    quickdb=quickdb.append(pd.Series(), ignore_index=True)
    
a=[i for i in range(len(chargeddb))]
quickdb['test']=a; chargeddb['test']=a; 
movesdb=quickdb.merge(chargeddb,on='test').drop('test',axis=1)
movesdb.to_csv('Pokemon Data/Movesdb.csv' , encoding='utf_8_sig', header=False, index=False)