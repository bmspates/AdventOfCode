import fileinput

def adj_check(num):
    num = str(num)
    return num[0] == num[1] or num[1] == num[2] or num[2] == num[3] or num[3] == num[4] or num[4] == num[5]

def inc_check(num):
    num = [ char for char in str(num) ]
    for i, char in enumerate(num[:5]):
        if int(char) > int(num[i + 1]):
            return False
    return True

def adj2_check(num):
    num = [ char for char in str(num) ]
    i = 0
    while i < len(num) - 1:
        count = 1
        for j in range(i + 1, len(num)):
            if num[i] == num[j]:
                count += 1
            else:
                break
        if count == 2:
            return True
        i += count
    return False

data = [ line.strip() for line in open("inputs/day4.txt", 'r') ]

data = data[0].split('-')
min_val = int(data[0])
max_val = int((data[1]))

count, count2 = 0, 0
for i in range(min_val, max_val + 1):
    if adj_check(i) and inc_check(i):
        count += 1
    if adj2_check(i) and inc_check(i):
        count2 += 1
print(count, count2)