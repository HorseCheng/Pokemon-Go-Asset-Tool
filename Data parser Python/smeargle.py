import re

date, version = "", ""
with open("Version.txt", "r") as f:
    s = f.readlines()
    date = s[0][0:-1]
    version = s[1][0:-1]

emerged = open("Merge/" + version + "emerged.txt", "r", encoding="UTF-8")
eng = emerged.readlines()
merged = open("Merge/" + version + "merged.txt", "r", encoding="UTF-8")
chi = merged.readlines()
masterfile = open("Game_Master/" + date + ".txt", "r", encoding="UTF-8")
master = masterfile.readlines()

move = [[], [], []]  # 0: move name #1: move number #2: chi name
pokequickmove = ""
pokechargemove = ""
for i in range(0, len(master)):
    if "WEATHER_AFFINITY" in master[i]:
        break
    x = re.search('template_id: "V[0-9]+_MOVE_', master[i])
    if x:
        num = int(re.search("[0-9]+", master[i]).group())
        name = re.search("MOVE_[A-Z\_]+", master[i]).group()
        name = name.replace("MOVE_", "")
        move[0].append(name)
        move[1].append(num)
check = 1
checknum = 0
remember = 0
noww = 0
mewq = ""
mewc = ""
for i in range(0, len(move[1])):
    for e in range(noww, len(chi)):
        if "move_reroll_confirm_desc" in chi[i]:
            break
        if "move_name_" in chi[e] and str(move[1][i]) in chi[e]:
            move[2].append(
                re.search("[\u4e00-\u9fa5]+", chi[e + 1]).group()
            )  # Search for chinese word
            break

# p
for i in range(len(master)):
    if 'template_id: "SMEARGLE_MOVES_SETTINGS' in master[i]:
        for y in range(i + 2, len(master)):
            name = re.search("quick_moves: [A-Z\_]+", master[y])
            index = re.search("quick_moves: [0-9]+", master[y])
            if name:
                name = name.group().replace("quick_moves: ", "")
                for z in range(0, len(move[0])):
                    if move[0][z] == name:
                        mewq += "\n" + move[2][z]
            if index:
                index = int(re.search("[0-9]+", master[i]).group())
                ok = 1
                for z in range(0, len(move[1])):
                    if index == move[1][z]:
                        mewq += "\n" + move[0][z]
                        ok = 0
                if ok:
                    print("error!")
            if "template_id:" in master[y]:
                mewq += " \n"
                break

for i in range(len(master)):
    if 'template_id: "SMEARGLE_MOVES_SETTINGS' in master[i]:
        for y in range(i + 2, len(master)):
            name = re.search("cinematic_moves: [A-Z\_]+", master[y])
            index = re.search("cinematic_moves: [0-9]+", master[y])
            if name:
                name = name.group().replace("cinematic_moves: ", "")
                have = 0
                for z in range(0, len(move[0])):
                    if move[0][z] == name:
                        if move[2][z] not in mewc:
                            mewc += "\n" + move[2][z]
                            break
            if index:
                ok = 1
                index = int(re.search("[0-9]+", master[i]).group())
                for z in range(0, len(move[1])):
                    if index == move[1][z]:
                        mewc += "\n" + move[0][z]
                        ok = 0
                if ok:
                    print(num, index, "error!", master[y])
            if "template_id:" in master[y]:
                mewq += " \n"
                break
print(mewq, "\n")
print(mewc)
