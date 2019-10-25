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


# print English name
for i in range(0, len(master)):
    if 'template_id: "FORMS_V0494_POKEMON_VICTINI"' in master[i]:
        for q in range(i, len(master)):
            x = re.search('template_id: "FORMS_V[0-9]+_POKEMON_[A-Za-z]+', master[q])
            if x:
                name = re.findall("_[A-Za-z]+", master[q])[-1].strip("_")
                print(name.capitalize())
        break


# print gender ratio
check = 1
checknum = 0

genderstr = []
okk = 0
for i in range(0, len(master)):
    if "V0001_POKEMON" in master[i]:
        okk = okk + 1
        if okk == 9:
            break
    x = re.search('template_id: "SPAWN_V[0-9]+_POKEMON_', master[i])
    if x:
        num = int(re.search("[0-9]+", master[i]).group())
        if num < 494:
            continue

        # find duplicated data
        if num in [386, 479, 493]:
            if "NORMAL" in master[i] or "ORIGIN" in master[i]:
                i += 40
                continue
        if num != checknum:
            check = 1
        if (num in [550, 555, 585, 586, 641, 642, 645, 646, 647, 648, 649]) and (check):
            check = 0
            checknum = num
            i += 40
            continue

        gender = [0, 0, 0]  # male,female,non gender
        for tt in range(i, len(master)):
            if "genderless_percent" in master[tt]:
                gender[2] = 1
                break
            if "female_percent" in master[tt]:
                gender[1] = re.search("[0-9\.]+", master[tt]).group()
                continue
            if "male_percent" in master[tt]:
                gender[0] = re.search("[0-9\.]+", master[tt]).group()
            if "}" in master[tt]:
                i = tt
                break
        if float(gender[2]):
            genderstr.append("無性別")  # No Gender
        elif float(gender[0]) and float(gender[1]):
            genderstr.append(str(gender[0]))
        elif float(gender[0]) == 0:
            genderstr.append("全女性")  # All Female
        elif float(gender[1]) == 0:
            genderstr.append("全男性")  # All Male
for i in genderstr:
    print(i)
