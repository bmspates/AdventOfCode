import re

FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

def valid(passport, valid_fields):
    return valid_fields == len(FIELDS) or "cid" not in passport.keys() and valid_fields == len(FIELDS) - 1

def solve(data):
    count1, count2 = 0, 0
    for passport in data:
        l1 = 0
        for field in passport.keys():
            if field == FIELDS[0]: # byr
                l1+= 1 if 1920 <= int(passport[field]) <= 2002 else 0
            elif field == FIELDS[1]: #iyr 
                l1+= 1 if 2010 <= int(passport[field]) <= 2020 else 0
            elif field == FIELDS[2]: # eyr
                l1+= 1 if 2020 <= int(passport[field]) <= 2030 else 0
            elif field == FIELDS[3]: # hgt
                s = passport[field]
                if passport[field][-2:] == "cm":
                   l1 += 1 if 150 <= int(s[:-2]) <= 193 else 0 
                elif s[-2:] == "in":
                    l1 += 1 if 59 <= int(s[:-2]) <= 76 else 0
            elif field == FIELDS[4]: # hcl
                l1 += 1 if re.search("#[a-f0-9]{6}", passport[field]) is not None else 0
            elif field == FIELDS[5]: # ecl
                l1 += 1 if passport[field] in {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"} else 0
            elif field == FIELDS[6]: # pid
                l1 += 1 if len(passport[field]) == 9 and passport[field].isdigit() else 0
            elif field == FIELDS[7]: #cid (OPTIONAL)
                l1 += 1
        l2 =len({ field for field in passport.keys() if field in FIELDS }) 
        count1 += 1 if valid(passport, l1) else 0
        count2 += 1 if valid(passport, l2) else 0
    return count1, count2


data = [ line.strip() for line in open("inputs/day4.txt", 'r') ]

passports = []
map_ = dict()
for line in data:
    if line == "":
        passports.append(map_)
        map_ = {}
        continue
    for pair in line.split(' '):
        split = pair.split(':')
        map_[split[0]] = split[1]
passports.append(map_)

print(solve(passports))