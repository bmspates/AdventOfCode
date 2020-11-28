import itertools, sys

def visit(wire, count_steps):
    visited = set()
    location = (0, 0)
    step_map = dict()
    steps = 0
    for move in wire:
        direction = move[0]
        magnitude = int(move[1:])
        dx = {"R" : 1, "L" : -1, "U" : 0, "D" : 0}[direction]
        dy = {"R" : 0, "L" : 0, "U" : 1, "D" : -1}[direction]
        for _ in range(magnitude):
            location = (location[0] + dx, location[1] + dy)
            steps += 1
            if (count_steps):
                step_map[location] = steps
            visited.add(location)
    if count_steps:
        return visited, step_map
    else:
        return visited

def manhattan_distance(point1, point2):
    return abs(point1[0] - point2[0]) + abs(point1[1] - point2[1])

data = [ line.strip() for line in open("inputs/day3.txt", 'r') ]
wire1 = data[0].split(',')
wire2 = data[1].split(',')

visited = visit(wire1, False)
intersections = visited & visit(wire2, False)
distances = { manhattan_distance(point, (0, 0)) for point in intersections }
print(min(distances))

visited1, steps1 = visit(wire1, True)
visited2, steps2 = visit(wire2, True)
min_val = sys.maxsize
for location in intersections:
    total_steps =  steps1[location] + steps2[location]
    min_val = min(min_val, total_steps)
print(min_val)