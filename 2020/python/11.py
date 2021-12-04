import itertools

class Seat:
    seats = set()
    locations = dict()
    data = []
    deltas = [ pair for pair in itertools.product(range(-1, 2), range(-1, 2)) if pair != (0, 0)]

    def __init__(self, x, y, occupied = False):
        self.x = x
        self.y = y
        self.occupied = occupied
        self.adjacencies = set()
        Seat.locations[(x, y)] = self
        Seat.seats.add(self)
    
    def determine_adjacencies(data):
        Seat.data = data
        for seat in Seat.seats:
            for dx, dy in Seat.deltas:
                if (seat.x + dx, seat.y + dy) in Seat.locations:
                    seat.adjacencies.add(Seat.locations[(seat.x + dx, seat.y + dy)])
    
    def empty_all():
        for seat in Seat.seats:
            seat.occupied = False

    def visible(self):
        x, y, count = self.x, self.y, (0, 0) # count = (count_occupied, count_empty)
        for delta in Seat.deltas:
            for i in itertools.count(1):
                if (x + i * delta[0], y + i * delta[1]) in Seat.locations:
                    count = (count[0] + 1, count[1]) if Seat.locations[(x + i * delta[0], y + i * delta[1])].occupied else (count[0], count[1] + 1)
                    break
                if x + i * delta[0] not in range(0, len(Seat.data[0])) or  y + i * delta[1] not in range(0, len(Seat.data)): 
                    break
        return count
    
    def update_all(p_one = True):
        updates = {}
        for seat in Seat.seats:
            adj_occupied = len([ adj for adj in seat.adjacencies if adj.occupied ])
            vis_occupied, vis_empty = seat.visible()
            if seat.occupied:
                if p_one and adj_occupied > 3:
                    updates[seat] = False
                elif not p_one and vis_occupied > 4:
                    updates[seat] = False
            elif not seat.occupied:
                if p_one and adj_occupied == 0 or not p_one and vis_occupied == 0:
                    updates[seat] = True
        for seat in updates.keys():
            seat.occupied = updates[seat]
        if len(updates.keys()) == 0:
            return False
        return True
    
    def num_occupied():
        return len([ seat for seat in Seat.seats if seat.occupied ])


def part_one(data):
    while(Seat.update_all()):
        pass
    return Seat.num_occupied()

def part_two(data):
    while(Seat.update_all(False)):
        pass
    return Seat.num_occupied()


data = [ line.strip() for line in open("../inputs/day11.txt", 'r') ]
# data = [ line.strip() for line in open("../inputs/tests/11.txt", 'r') ]

layout = []
for y, line in enumerate(data):
    row = []
    for x, char in enumerate(line):
        if char == 'L':
            Seat(x, y)
        elif char == '#':
            Seat(x, y, True)
        row.append(char)
    layout.append(row)

Seat.determine_adjacencies(data)
print(part_one(layout))
Seat.empty_all()
print(part_two(layout))
