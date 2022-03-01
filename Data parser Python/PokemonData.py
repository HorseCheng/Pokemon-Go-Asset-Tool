import re
import json
import pandas as pd

date, version = "", ""

with open("Version.txt", "r") as f:
    s = f.readlines()
    date = s[0][0:-1]
    version = s[1][0:-1]
print(date, version)

with open("Merge/" + version + "english.json", encoding="UTF-8") as f:
    eng = json.load(f)
eng = eng ["data"]

with open("Merge/" + version + "chinesetraditional.json", encoding="UTF-8") as f:
    chi = json.load(f)
chi = chi ["data"]

with open("Game_Master/" + date + ".json") as f:
    master = json.load(f)
master=master ["template"]

typeeform = open("Coefficient/Type.txt", "r", encoding="UTF-8")
weatherform = open("Coefficient/Weather.txt", "r", encoding="UTF-8")

#Pokemon Go Home Pokemon
forbiddenlist=["V0351_POKEMON_CASTFORM_HOME_FORM_REVERSION","V0421_CHERRIM_HOME_FORM_REVERSION", "V0487_POKEMON_GIRATINA_HOME_REVERSION","V0555_POKEMON_DARMANITAN_HOME_FORM_REVERSION","V0647_POKEMON_KELDEO_HOME_FORM_REVERSION","V0648_POKEMON_MELOETTA_HOME_FORM_REVERSION","V0649_POKEMON_GENESECT_HOME_FORM_REVERSION"]


#Preprocess
typee={}
for line in typeeform:
   (key, val) = line.split()
   typee[key] = val 

weather={}
for line in weatherform:
   (key, *val) = line.split()
   weather[key] = val

catdict={}; introdict={}; MEGAintrodict={}
for value,char in enumerate(chi):
    x=re.search("pokemon_category_[0-9]+", char)
    if(x):
        key=re.findall("[0-9]+",char)
        if len(key)==1:
            catdict[str(key[0])]=chi[value+1].replace("_x000D_"," ")
        else:
            if int(key[1])<100: 
                catdict[str(key[0])+"_ALOLA"]=chi[value+1].replace("_x000D_"," ")
            else:
                catdict[str(key[0])+"_GALARIAN"]=chi[value+1].replace("_x000D_"," ")

    x=re.search("pokemon_desc_[0-9]+", char)
    if(x):
        key=re.findall("[0-9]+", char)
        if len(key)==1:
            introdict[str(key[0])]=chi[value+1].replace("_x000D_"," ")
        else:
            if int(key[1])<100: 
                introdict[str(key[0])+"_ALOLA"]=chi[value+1].replace("_x000D_"," ")
            else:  
                introdict[str(key[0])+"_GALARIAN"]=chi[value+1].replace("_x000D_"," ")

    x=re.search("pokemon_desc_tmpevo_[0-9]+", char)
    if(x):
        key=re.findall("[0-9]+", char)
        if MEGAintrodict.get(str(key[0])+"_1") == None:
            MEGAintrodict[str(key[0])+"_1"]=chi[value+1].replace("_x000D_"," ")
        else:  
            MEGAintrodict[str(key[0])+"_2"]=chi[value+1].replace("_x000D_"," ")

#New Pokemon, still don't have description
#introdict["0562_GALARIAN"] = ""

chinamedict={}
for value,char in enumerate(chi):
    try:
        key=re.findall("pokemon_name_([0-9_]+)", char)[0]
        chinamedict[key]=chi[value+1]
    except: pass
engnamedict={}
for value,char in enumerate(eng):
    try:
        key=re.findall("pokemon_name_([0-9_]+)", char)[0]
        engnamedict[key]=eng[value+1]
    except: pass

# New Pokemon
chinamedict["0866"] = "踏冰人偶"
engnamedict["0866"] = "Mr. Rime"

       
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

#New Move or replace move name
chimovedict["0292"] = "氣象球 (火)"
chimovedict["0293"] = "氣象球 (冰)"
chimovedict["0294"] = "氣象球 (岩石)"
chimovedict["0295"] = "氣象球 (水)"
chimovedict["0352"] = "氣象球 (一般)"
engmovedict["0352"] = "Weather Ball"

engmovedict["0336"] = "Techno Blast"
chimovedict["0336"] = "高科技光炮 (一般)"
engmovedict["0337"] = "Techno Blast"
chimovedict["0337"] = "高科技光炮 (火焰)"
engmovedict["0338"] = "Techno Blast"
chimovedict["0338"] = "高科技光炮 (冰凍)"
engmovedict["0339"] = "Techno Blast"
chimovedict["0339"] = "高科技光炮 (水流)"
engmovedict["0340"] = "Techno Blast"
chimovedict["0340"] = "高科技光炮 (閃電)"

chimovedict["0357"] = "魔法葉"
engmovedict["0357"] = "Magical Leaf"
chimovedict["0358"] = "神聖之火"
engmovedict["0358"] = "Sacred Fire"
chimovedict["0359"] = "冰錐"
engmovedict["0359"] = "Icicle Spear"
chimovedict["0360"] = "氣旋攻擊+"
engmovedict["0360"] = "Aeroblast +"
chimovedict["0361"] = "氣旋攻擊++"
engmovedict["0361"] = "Aeroblast ++"
chimovedict["0362"] = "神聖之火+"
engmovedict["0362"] = "Sacred Fire +"
chimovedict["0363"] = "神聖之火++"
engmovedict["0363"] = "Sacred Fire ++"
chimovedict["0364"] = "雜技"
engmovedict["0364"] = "Acrobatics"

# Pokemon class
class pokemon():
    def __init__(self, inn):
        settings=inn["data"]["pokemonSettings"]
        self.id = re.findall("V([0-9]+)",inn['templateId'])[0]
        self.name = re.findall("POKEMON_(\S+)",inn['templateId'])[0]
        self.chi = chinamedict[self.id]
        self.eng = engnamedict[self.id]
        self.type = self.typehandle(settings["type"])
        self.type2 = self.typehandle(settings.get("type2",""))
        self.weather1= self.weatherhandle(self.type)
        self.weather2= self.weatherhandle(self.type2, self.weather1)
        self.capture = self.capturehandle(settings["encounter"].get("baseCaptureRate","")) 
        self.flee = settings["encounter"].get("baseFleeRate","")
        self.atk = settings["stats"].get("baseAttack",0)
        self.deff= settings["stats"].get("baseDefense",0)
        self.hp= settings["stats"].get("baseStamina",0)
        self.height= settings.get("pokedexHeightM",0)
        self.weight= settings.get("pokedexWeightKg",0)
        self.candy= self.candyhandle(settings.get("evolutionBranch",""))
        self.thirdstardust= settings["thirdMove"].get("stardustToUnlock","")
        self.thirdcandy= settings["thirdMove"].get("candyToUnlock","")

        self.buddy = settings["kmBuddyDistance"]
        self.camdist = round(settings["encounter"].get("cameraDistance",0), 3)
        self.camrad = ""
        self.camheight = "" 
        try: 
            self.camrad = round(settings["encounter"]["collisionRadiusM"], 3)
            self.camheight = round(settings["encounter"]["collisionHeightM"], 3)
        except: 
            pass
        self.ratio=""
        self.desccat=self.descripthandle("cat")
        self.descintro=self.descripthandle("intro")
        self.quick=settings.get("quickMoves")
        self.charged=settings.get("cinematicMoves")

        self.mega= self.megahandle(settings, 1)
        self.mega2= self.megahandle(settings, 2)

        self.shadow = self.shadowhandle(settings)
     
    def typehandle(self, inn):
        if(inn==""): return ""
        return typee[inn]

    def weatherhandle(self, inn, one=""):
        for name, value in weather.items():
            if(inn in value): 
                if name!= one: return name
                else: return ""
        return ""
 
    def capturehandle(self, inn):
        return 1 if inn==100 else inn
    
    def candyhandle(self, inn):
        if(type(inn)==list ): 
            for i in inn:
                if "temporaryEvolution" not in i:
                    try:
                        return i["candyCost"]
                    except:
                        pass
            return ""
     
    def descripthandle(self, typee):
        if(typee=="cat"):
            if("ALOLA" in self.name):
                try: return catdict[self.id+"_ALOLA"]
                except: return catdict[self.id]
            if "GALARIAN" in self.name:
                try: return catdict[self.id+"_GALARIAN"]
                except: return catdict[self.id]
            try: 
                return catdict[self.id]
            except: 
                print(f"category error {self.id}")
                return ""

        if("ALOLA" in self.name):
            return introdict[self.id+"_ALOLA"]
        if "GALARIAN" in self.name:
            try: return introdict[self.id+"_GALARIAN"]
            except: return introdict[self.id]
        try: 
            return introdict[self.id]
        except: 
            print(f"description error {self.id}")
            return ""
    
    def ratiohandle(self, inn):
        if(inn.get("malePercent","")==1): self.ratio="全男性" 
        elif(inn.get("femalePercent","")==1): self.ratio="全女性"
        elif(inn.get("genderlessPercent","")==1): self.ratio="無性別"
        else: self.ratio=inn["malePercent"]

    def megahandle(self, inn, num):
        test=inn.get("tempEvoOverrides")
        if test== None: return None
        if num==2: 
            if len(test)==1: return None
        test=test[num-1]
        type1= self.typehandle(test.get("typeOverride",""))
        type2= self.typehandle(test.get("typeOverride2",""))
        weather1=self.weatherhandle(type1)
        weather2=self.weatherhandle(type2, weather1)
        des=MEGAintrodict[self.id+"_"+str(num)]
        
        for i in inn["evolutionBranch"]:
            if test["tempEvoId"]== i["temporaryEvolution"]:
                candy1= i["temporaryEvolutionEnergyCost"]
                candy2= i["temporaryEvolutionEnergyCostSubsequent"]
        
        return{"type1": type1,"type2": type2,"weather1": weather1,"weather2": weather2,
               "baseAttack": test["stats"]["baseAttack"], "baseDefense": test["stats"]["baseDefense"], 
               "baseStamina": test["stats"]["baseStamina"],
               "height": test["averageHeightM"], "weight": test["averageWeightKg"],
               "candy1": candy1, "candy2": candy2, "des": des
              }

    def shadowhandle(self, inn):
        test=inn.get("shadow")
        if test== None: return None
        purified_stardust = test["purificationStardustNeeded"]
        purified_candy = test["purificationCandyNeeded"]
        capture = inn["encounter"].get("shadowFormBaseCaptureRate","")
        flee = inn["encounter"].get("baseFleeRate","")
        
        return{"stardust": purified_stardust, "candy": purified_candy,
               "capture": capture, "flee": flee
              }


# Move class   
class move():
    def __init__(self, inn):
      settings=inn["data"]["moveSettings"]
      self.id = re.findall("V([0-9]+)",inn['templateId'])[0]
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
                    if(abs(inn["buffs"][char])==3):  number=" 3 層"
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
def rearrange(dataframe, poke1, poke2):
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
        if (data["templateId"] not in forbiddenlist):
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
                pokelist[i].ratiohandle(data["data"]["genderSettings"]["gender"])
                noww=i; break
        else:
            print("ratio error",data["templateId"]) #Didn't found, weird situation

#PVP Moves Info
noww=-1
for data in master:
    if(re.search("COMBAT_V[0-9]+_MOVE_", data["templateId"])):
        for i in range(noww+1, len(movelist)):
            if str(movelist[i].name) in data["templateId"]:
                movelist[i].pvphandle(data["data"]["combatMove"])
                noww=i; break
        else: print("pvp error", data["templateId"]) #Didn't found, weird situation


    
#Special condition: make DEOXYS's and CASTFORM's moves the same as DEOXYS_NOMARL and CASTFORM_NOMARL have
for x in pokelist:
    if x.name == 'CASTFORM':
        for y in pokelist:
            if y.name == 'CASTFORM_NORMAL' :
                x.quick=y.quick; x.charged=y.charged

    elif x.name == 'DEOXYS':
        for y in pokelist:
            if y.name == 'DEOXYS_NORMAL':
                x.quick=y.quick; x.charged=y.charged
    
#Pokemon Moves Translation
for i in pokelist:
    if i.quick != None:   
        for value,char in enumerate(i.quick):
            for z in movelist:
                if z.name==char:
                    i.quick[value]=z.chi
    if i.charged != None:
        for value, char in enumerate(i.charged):
            for z in movelist:
                if z.name==char:
                    i.charged[value]=z.chi  

# Output file
origin = pd.DataFrame([i.__dict__ for i in pokelist])

main = origin[ ~origin['name'].str.contains('NORMAL|PUMPKABOO$|GOURGEIST$|BURMY$|WORMADAM$|CHERRIM$|SHELLOS$|GASTRODON$|GIRATINA$|SHAYMIN$|BASCULIN$|DARMANITAN$|DEERLING$|SAWSBUCK$|TORNADUS$|THUNDURUS$|LANDORUS$|KELDEO$|MELOETTA$|NATURAL$|HOOPA$|TOXTRICITY$|SINISTEA$|POLTEAGEIST$|INDEEDEE_MALE$|MORPEKO$|ZACIAN$|ZAMAZENTA$|FLABEBE$|FLOETTE$|FLORGES$|URSHIFU$|SHADOW$|PURIFIED$|MIDDAY$|SOLO$|METEOR$|DISGUISED$|_S$') ].reset_index(drop=True)
main = main.sort_values(by=['id'],kind='mergesort').reset_index(drop=True)

#main with Apex Shadow pokemon
main_s = origin[ ~origin['name'].str.contains('NORMAL|PUMPKABOO$|GOURGEIST$|BURMY$|WORMADAM$|CHERRIM$|SHELLOS$|GASTRODON$|GIRATINA$|SHAYMIN$|BASCULIN$|DARMANITAN$|DEERLING$|SAWSBUCK$|TORNADUS$|THUNDURUS$|LANDORUS$|KELDEO$|MELOETTA$|NATURAL$|HOOPA$|TOXTRICITY$|SINISTEA$|POLTEAGEIST$|INDEEDEE_MALE$|MORPEKO$|ZACIAN$|ZAMAZENTA$|FLABEBE$|FLOETTE$|FLORGES$|URSHIFU$|SHADOW$|PURIFIED$|MIDDAY$|SOLO$|METEOR$|DISGUISED$') ].reset_index(drop=True)
main_s = main_s.sort_values(by=['id'],kind='mergesort').reset_index(drop=True)


# Rearange for DEERLING AUTUMN
main = rearrange(main, 'DEERLING_AUTUMN', 'DEERLING_SUMMER' )
main = rearrange(main, 'SAWSBUCK_AUTUMN', 'SAWSBUCK_SUMMER' )
main = rearrange(main, 'PUMPKABOO_SMALL', 'PUMPKABOO_LARGE')
main = rearrange(main, 'GOURGEIST_SMALL', 'GOURGEIST_LARGE')

# =============================================================================
# Main Pokemon List
# =============================================================================
maindb = main.drop(["id","name","chi","eng","quick","charged","mega","mega2","shadow"], axis=1)
mainheader = main[["id","name","chi","eng"]]
maindb.to_csv('Pokemon Data/Pokemondb.csv' , encoding='utf_8_sig', header=False, index=False)
mainheader.to_csv('Pokemon Data/Pokemonheader.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# Shadow Pokemon List
# =============================================================================
shadow = main_s[~ main_s["shadow"].isnull()]
pokename = shadow[["name", "chi","eng","id"]].astype({"id": int}).set_index('id').reset_index()
shadowinfo = pd.DataFrame(list(shadow["shadow"]))
shadowmerge = pd.concat([pokename,shadowinfo],axis=1)
shadow = shadowmerge.sort_values(by=['id'],kind='mergesort')
shadow.to_csv('Pokemon Data/Shadows.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# Mega Pokemon List
# =============================================================================
mega1 = main[~ main["mega"].isnull()].drop_duplicates(subset ="chi") 
pokename1 = mega1[["chi","eng","id"]].astype({"id": int}).set_index('id').reset_index()
megainfo1 = pd.DataFrame(list(mega1["mega"]))
megamerge1 = pd.concat([pokename1,megainfo1],axis=1)

mega2 = main[~ main["mega2"].isnull()]
pokename2 = mega2[["chi","eng","id"]].astype({"id": int}).set_index('id').reset_index()
megainfo2 = pd.DataFrame(list(mega1["mega"]))
megainfo2 = pd.DataFrame(list(mega2["mega2"]))
megamerge2 = pd.concat([pokename2, megainfo2], axis=1)

megaout = pd.concat([megamerge1,megamerge2]).sort_values("id")
megaout.insert(3, "Empty", "", True) 
megaout.insert(15, "Empty", "", True) 
megaout.to_csv('Pokemon Data/Mega.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# Pokemon Move
# =============================================================================
# Move MEW to last line and Segment Mew
pokename = main[["id","name","chi","eng"]]
quickmove = main["quick"].tolist()
chargedmove = main["charged"].tolist()

mewindex = pokename[pokename['name'] =='MEW'].index[0]
mewquick = quickmove[mewindex]
mewcharged = chargedmove[mewindex]
mewcharged = list(set(mewcharged))
mewline = pokename.iloc[mewindex]
del quickmove[mewindex], chargedmove[mewindex]
pokename = pokename.drop(mewindex).append(mewline)

print(f"#max quick: {maxquick}, #max charged: {maxcharged}")
temp = [mewquick[x:x+maxquick] for x in range(0, len(mewquick),maxquick)]
quickmove.extend(temp)
temp = [mewcharged[x:x+maxcharged] for x in range(0, len(mewcharged),maxcharged)]
chargedmove.extend(temp)

x = pd.Series(quickmove).apply(pd.Series)
y = pd.Series(chargedmove).apply(pd.Series)
lenx = len(x);leny=len(y);lenpoke=len(pokename)
for _ in range(leny-lenx):
    x = x.append(pd.Series(), ignore_index=True)
for _ in range(leny-lenpoke):
    pokename=pokename.append(pokename.iloc[-1], ignore_index=True)   
a = [i for i in range(leny)]
y['test']=a; x['test']=a; pokename['test']=a

pokemove = pokename.merge(x,on='test').merge(y,on='test').drop('test',axis=1)
pokemoveheader = pokemove[["id","name","chi","eng"]]
pokemovedb = pokemove.drop(["id","name","chi","eng"], axis=1)
pokemoveheader.to_csv('Pokemon Data/Pokemoveheader.csv' , encoding='utf_8_sig', header=False, index=False)
pokemovedb.to_csv('Pokemon Data/Pokemovedb.csv' , encoding='utf_8_sig', header=False, index=False)

# =============================================================================
# Moves Info
# =============================================================================
quickdb=[]; chargeddb=[]
moveorigin=[i.__dict__ for i in movelist]
for i in moveorigin:
    if i["quick"]== True:
        quickdb.append(i)
    else: chargeddb.append(i)
quickdb = pd.DataFrame(quickdb).drop(["name","quick","buff","buffchance"],axis=1)
chargeddb = pd.DataFrame(chargeddb).drop(["name","quick","turnpvp"],axis=1)

quickdb.insert(8, "split", "")
quickdb.insert(quickdb.shape[1], "split2", "")
chargeddb.insert(8, "split", "")
chargeddb.insert(11, "split2", "")

for _ in range(len(chargeddb)-len(quickdb)):
    quickdb = quickdb.append(pd.Series(dtype="float64"), ignore_index=True)
    
a = [i for i in range(len(chargeddb))]
quickdb['test'] = a; chargeddb['test'] = a; 
movesdb = quickdb.merge(chargeddb,on='test').drop('test',axis=1)
movesdb.to_csv('Pokemon Data/Movesdb.csv' , encoding='utf_8_sig', header=False, index=False)