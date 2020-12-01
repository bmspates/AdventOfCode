import itertools

data = [ line.strip() for line in open("inputs/day01.txt", 'r') ]
data = [ int(num) for num in data ]

for i, num1 in enumerate(data):
    for j, num2 in enumerate(data):
        if i != j and num1 + num2  == 2020:
            print("Part one: " + str(num1 * num2))

for i, num1 in enumerate(data):
    for j, num2 in enumerate(data):
        for k, num3 in enumerate(data):
            if i != j and j != k and i != k and num1 + num2 + num3 == 2020:
                print("Part two: " + str(num1 * num2 * num3))