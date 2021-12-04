import itertools, numpy

def solve(data, slope):
    x, y, count = slope[0], slope[1], 0
    while y < len(data):
        if data[y % len(data)][x % len(data[0])] == '#':
            count += 1
        x, y = x + slope[0], y + slope[1]
    return count

data = [ line.strip() for line in open("../inputs/day3.txt", 'r') ]
tmp = []
for row in data:
    tmp.append([ char for char in row ])
data = tmp

print("Part One:", solve(data.copy(), (3, 1)))
slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
print("Part Two:", numpy.prod([solve(data.copy(), slope) for slope in slopes]))