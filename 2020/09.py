import itertools

def part_one(data):
    prev = []
    for num in data[:25]:
        prev.append(num)
    i = 25
    flag = True
    while flag:
        flag = False
        num = data[i]
        for a, b in itertools.permutations(prev, 2):
            if num == a + b:
                flag = True
                break
        i += 1
        prev.pop(0)
        prev.append(num)
    return data[i - 1]


def part_two(data, n):
    for l in range(len(data)):
        for r in range(l + 2, len(data)):
            if sum(data[l:r + 1]) == n:
                return min(data[l:r+1]) + max(data[l:r+1])


data = [ int(line.strip()) for line in open("inputs/day9.txt", 'r') ]

p1 = part_one(data)
p2 = part_two(data, p1)
print("{}\n{}".format(p1, p2))