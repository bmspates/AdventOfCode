def part_one(data):
    ret_val = 0
    for line in data:
        nums = line[0].split('-')
        count = 0
        for letter in line[2]:
            if letter == line[1][0]:
                count += 1
        if int(nums[0]) <= count <= int(nums[1]):
            ret_val += 1
    return ret_val

def part_two(data):
    ret_val = 0
    for line in data:
        letter = line[1][0]
        nums = [ int(n) - 1 for n in line[0].split('-') ]
        if bool(line[2][nums[0]] == letter) ^ bool(line[2][nums[1]] == letter):
            ret_val += 1
    return ret_val


data = [ line.strip().split(' ') for line in open("../inputs/day02.txt", 'r') ]

print(part_one(data.copy()))
print(part_two(data.copy()))