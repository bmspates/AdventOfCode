import itertools

def visit(wire):
    visted = set()
    location = (0, 0)
    for move in wire:
        direction = move[0]
        magnitude = int(move[1:])
        dx = {"R" : 1, "L" : -1, "U" : 0, "D" : 0}[direction]
        dy = {"R" : 0, "L" : 0, "U" : 1, "D" : -1}[direction]
        for _ in range(magnitude):
            location = (location[0] + dx, location[1] +dy)
            visted.add(location)
    return visted

def manhattan_distance(point1, point2):
    return abs(point1[0] - point2[0]) + abs(point1[1] - point2[1])

data = [ line.strip() for line in open("inputs/day3.txt", 'r') ]
wire1 = data[0].split(',')
wire2 = data[1].split(',')

visted = visit(wire1)
intersections = [ location for location in visit(wire2) if location in visted ]
distances = [ manhattan_distance(point, (0, 0)) for point in intersections ]
print(min(distances))