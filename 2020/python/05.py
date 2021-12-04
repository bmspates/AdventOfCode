import math, itertools

def get_bounds(char, l, r):
    if char == 'F' or char == 'L':
        return l, math.floor((l +r) / 2)
    elif char == 'B' or char == 'R':
        return math.ceil((l + r) / 2), r

def solve(data):
    IDs = set()
    # Part One
    for line in data:
        l, r = 0, 127
        for char in line[:7]:
            l, r = get_bounds(char, l, r)
        row = l
        l, r = 0, 7
        for char in line[7:]:
            l, r = get_bounds(char, l, r)
        col = l
        IDs.add(row * 8 + col)
    # Part Two
    for row, col in itertools.product(range(128), range(8)):
        id = row * 8 + col
        if id not in IDs and id + 1 in IDs and id - 1 in IDs:
            return max(IDs), id

data = [ line.strip() for line in open("../inputs/day5.txt", 'r') ]

list_ = []
for i, line in enumerate(data):
    list_.append([])
    list_[i] = [char for char in line]


print(solve(list_.copy()))