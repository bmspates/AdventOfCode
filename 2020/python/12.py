# import itertools, numpy

def solve(data):
    pass

def part_one(data):
    loc, theta = (0, 0), 0
    for line in data:
        action, value = line[0], line[1]
        if action == "N":
            loc = (loc[0], loc[1] + value)
        elif action == "S":
            loc = (loc[0], loc[1] - value)
        elif action == "E":
            loc = (loc[0] + value, loc[1])
        elif action == "W":
            loc = (loc[0] - value, loc[1])
        elif action == "R": 
            theta = (theta - value) % 360
        elif action == "L": 
            theta = (theta + value) % 360
        elif action == "F": 
            if theta == 0:
                loc = (loc[0] + value, loc[1])
            elif theta == 90:
                loc = (loc[0], loc[1] + value)
            elif theta == 180:
                loc = (loc[0] - value, loc[1])
            elif theta == 270:
                loc = (loc[0], loc[1] - value)
            else:
                print("angles are mean")
    return(abs(loc[0]) + abs(loc[1]))

def part_two(data):
    loc, offset = (0, 0), (10, 1)
    for line in data:
        action, value = line[0], line[1]
        if action == "N":
            loc = (loc[0], loc[1] + value)
        elif action == "S":
            loc = (loc[0], loc[1] - value)
        elif action == "E":
            loc = (loc[0] + value, loc[1])
        elif action == "W":
            loc = (loc[0] - value, loc[1])
        elif action == "R": 
            theta = (theta - value) % 360
        elif action == "L": 
            theta = (theta + value) % 360
        elif action == "F": 
            if theta == 0:
                loc = (loc[0] + value, loc[1])
            elif theta == 90:
                loc = (loc[0], loc[1] + value)
            elif theta == 180:
                loc = (loc[0] - value, loc[1])
            elif theta == 270:
                loc = (loc[0], loc[1] - value)



data = [ line.strip() for line in open("../inputs/day12.txt", 'r') ]

instructions = []
for line in data:
    instructions.append((line[0], int(line[1:])))

print(part_one(instructions))