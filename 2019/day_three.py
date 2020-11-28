import fileinput, itertools, shapely

class Point:

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return "(" + str(self.x) + ", " + str(self.y) + ")"

    def __add__(self, other):
        return Point(self.x + other.x, self.y + other.y)

    def manhattan_distance(self, point):
        return abs(self.x - point.x) + abs(self.y - point.y)

class Line:
    def __init__(self, start, direction, distance):
        self.start = start
        if direction == 'R':
            self.end = Point(start.x + distance, start.y)
        elif direction == 'L':
            self.end = Point(start.x - distance, start.y)
        elif direction == 'U':
            self.end = Point(start.x, start.y + distance)
        elif direction == 'D':
            self.end = Point(start.x, start.y - distance)
        self.distance = distance
    
    def __str__(self):
        return "Start: " + str(self.start) + ", End: " + str(self.end)

    def has_point(self, point):
        return self.start.x <= point.x <= self.end.x and self.start.y <= point.y <= self.end.y

    def intersect(self, other) -> Point:
        if self.start.x == self.end.x and other.start.y == other.end.y:
            intersection = Point(self.start.x, other.start.y)
        elif self.start.y == self.end.y and other.start.x == other.end.x:
            intersection = Point(other.start.x, self.start.y)
        else:
            return
        if self.has_point(intersection) and other.has_point(intersection):
            return intersection


def make_list(wire):
    line = []
    current_point = Point(0, 0)
    for i in range(len(wire) - 1):
        line.append(Line(current_point, wire[i][0], int(wire[i][1:])))
        current_point = line[i].end
    return line


data = [ line.strip() for line in open("inputs/tests/3/2.txt") ]
wire1 = make_list(data[0].split(','))
wire2 = make_list(data[1].split(','))

intersection_points = []
for l1, l2 in itertools.product(wire1, wire2):
    p = l1.intersect(l2)
    if p is not None:
        intersection_points.append(p)

zero = Point(0, 0)
distances = [ p.manhattan_distance(zero) for p in intersection_points ]
print(min(distances))
