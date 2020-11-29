import fileinput

def crawl(orbits, orbit_counts, curr, count):
    orbit_counts[curr] = count
    if curr not in orbits:
        return
    for point in orbits[curr]:
        crawl(orbits, orbit_counts, point, count + 1)

# Returns true if node1 and node2 are reachable from curr
def reachable(orbits, curr, node1, node2):
    visited = set()
    dfs(orbits, curr, visited)
    return node1 in visited and node2 in visited

def dfs(orbits, curr, visited):
    if curr not in visited:
        visited.add(curr)
        if curr not in orbits:
            return
        for node in orbits[curr]:
            dfs(orbits, node, visited)

# Counts the number of nodes in between curr and node
def count_to(orbits, curr, dest, count):
    for node in orbits[curr]:
        if node == dest:
            return count
        if reachable(orbits, node, dest, dest):
            return count_to(orbits, node, dest, count + 1)


data = [ line.strip() for line in open("inputs/day6.txt", 'r') ]
# data = [ line.strip() for line in open("inputs/tests/6/2.txt", 'r') ]
orbits = dict()
for line in data:
    temp = line.split(")")
    orbits[temp[0]] = [] if temp[0] not in orbits else orbits[temp[0]]
    orbits[temp[0]].append(temp[1]) 

orbit_counts = dict()
crawl(orbits, orbit_counts, "COM", 0)
print("Part One: " + str(sum(orbit_counts.values())))

curr = "COM"
while True:
    flag = True
    for node in orbits[curr]:
        if reachable(orbits, node, "YOU", "SAN"):
            curr = node
            flag = False
            break
    if flag:
        counts = []
        counts.append(count_to(orbits, curr, "YOU", 0))
        counts.append(count_to(orbits, curr, "SAN", 0))
        break
print("Part Two: " + str(sum(counts)))