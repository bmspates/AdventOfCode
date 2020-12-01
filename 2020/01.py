import itertools, numpy

def solve(data, n):
    for nums in itertools.permutations(data, n):
        if sum(nums) == 2020:
            return numpy.prod(nums)

data = [ line.strip() for line in open("inputs/day01.txt", 'r') ]
data = [ int(num) for num in data ]

print(solve(data, 2))
print(solve(data, 3))