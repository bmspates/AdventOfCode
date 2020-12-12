# import itertools, numpy

def solve(data):
    diff = dict()
    curr, visited = 0, set()
    while True:
        order = [0]
        delta = 0
        for delta in range(1, 4):
            if curr + delta in data and curr + delta not in visited:
                temp = order.copy()
                temp.append(curr + delta)
                order = temp
                curr = curr + delta
                diff[delta] = 1 if delta not in diff else diff[delta] + 1
                visited.add(curr)
                break
        if delta == 4:
            break
        if curr == data[-1]:
            break
    return diff[1] * diff[3]

def num_paths(data, index, counts):
    if index == len(data) - 1: # Already at the end of the list
        return 1 
    if index in counts:
        return counts[index]
    count = 0
    for delta in range(1, 4): 
        if data[index] + delta in data:
            count += num_paths(data, data.index(data[index] + delta), counts)
    if index not in counts:
        counts[index] = count
    return count

data = [ int(line.strip()) for line in open("inputs/day10.txt", 'r') ]
# data = [ int(line.strip()) for line in open("inputs/tests/10.txt", 'r') ]

data.append(max({ num for num in data}) + 3)
data.sort()

print(solve(data.copy()))
data.insert(0, 0)
counts = {}
print(num_paths(data.copy(), 0, counts))