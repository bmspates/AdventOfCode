import math

def solve(data):
    IDs = set()
    for line in data:
        l, r = 0, 127
        for char in line[:7]:
            if char == 'F':
                r = math.floor((l +r) /  2)
            elif char == 'B':
                l = math.ceil(r / 2)
        row = l
        l, r = 0, 7
        for char in line[7:]:
            
        



def part_one(data):
    pass

def part_two(data):
    pass


data = [ line.strip() for line in open("inputs/day5.txt", 'r') ]

list_ = []
for i, line in enumerate(data):
    list_.append([])
    list_[i] = [char for char in line]


print(solve(list_.copy()))