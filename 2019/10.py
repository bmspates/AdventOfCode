import fileinput, math, numpy
from operator import itemgetter

class Asteriod:

    asteriods = set()
    varporized = []

    best_location = None

    @staticmethod
    def detect_all():
        for asteriod in Asteriod.asteriods:
            dists = []
            for other in Asteriod.asteriods:
                if other is not asteriod:
                    dists.append((other, asteriod.dist(other)))
            dists = sorted(dists, key=lambda x: x[1])
            for other, dists in dists:
                theta = math.atan2(other.y - asteriod.y, other.x - asteriod.x)
                if theta not in asteriod.detected.values():
                    asteriod.detected[other] = theta
                

    @staticmethod
    def complete_vaporization(count = -1):
        base = Asteriod.best_location
        fatalaties = 0
        if count == -1:
            count = len(Asteriod.asteriods) - 1
        for asteriod in Asteriod.asteriods:
            if asteriod is not base: # TODO Destruction order is wrong, take a closer look at offset construction
                theta = math.atan2(asteriod.y - base.y, asteriod.x - base.x)
                if math.pi / 2 >= theta >= 0:
                    asteriod.offset = abs(theta - (math.pi / 2))
                elif 0 > theta >= - math.pi:
                    asteriod.offset = math.pi / 2 + abs(theta)
                else:
                    asteriod.offset = (3 * math.pi / 2) + abs(theta - math.pi / 2)
        while fatalaties < count:
            next = min(base.detected, key=lambda x: x.offset)
            Asteriod.varporized.append(next)
            del base.detected[next]
            Asteriod.asteriods.remove(next)
            fatalaties += 1
            print("The {}th asteriod to be vaporized is at {}".format(fatalaties, (next.x, next.y)))
            Asteriod.detect_all()

    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.detected = dict()
        self.offset = None
        Asteriod.asteriods.add(self)
    
    def __str__(self):
        return "[{}, {}]".format(self.x, self.y)

    def dist(self, other):
        return math.sqrt((self.x - other.x) ** 2 + (self.y - other.y) ** 2)


# data = [ line.strip() for line in open("inputs/day10.txt", 'r') ]
data = [ line.strip() for line in open("inputs/tests/10.txt", 'r') ]

a_map = []

for i, line in enumerate(data):
    a_map.append([])
    for char in line:
        a_map[i].append(char)

for y, row in enumerate(a_map):
    for x, char in enumerate(row):
        if char == '.':
            continue
        Asteriod(x, y)

Asteriod.detect_all()
max_ = (None, 0)
for asteriod in Asteriod.asteriods:
    if len(asteriod.detected.values()) > max_[1]:
        max_ = (asteriod, len(asteriod.detected.values()))
Asteriod.best_location, num_detected = max_
print("Part One: {} from {}".format(num_detected, Asteriod.best_location))

Asteriod.complete_vaporization()