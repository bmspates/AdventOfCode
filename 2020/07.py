def count_bags(data, bag_check):
    count = 1
    if bag_check is None or data[bag_check] is None:
        return count
    for bag in data[bag_check].keys():
        count += int(data[bag_check][bag]) * count_bags(data, bag)
    return count

def contain(data, bag_check, bag_to_hold):
    if bag_check is None:
        return False
    for bag in bag_check.keys():
        if bag == bag_to_hold or contain(data, data[bag], bag_to_hold):
            return True
    return False
        
def part_one(data):
    count = 0
    for bag in data.keys():
        if contain(data, data[bag], "shiny gold"):
            count += 1
    return count

def part_two(data, bag_check):
    return count_bags(data, bag_check) - 1

data = [ line.strip() for line in open("inputs/day7.txt", 'r') ]

bags = dict()
for line in data:
    halves = line.split(" contain ")
    contains = halves[1].strip()[:-1].split(",")
    bag_type = halves[0][:-4].strip()
    if contains[0] != "no other bags":
        bags[bag_type] = dict()
        for bag in contains:
            split = bag.strip().split(" ")
            bags[bag_type][split[1] + " " + split[2]] = int(split[0])
    else:
        bags[bag_type] = None

print(part_one(bags.copy()))
print(part_two(bags.copy(), "shiny gold"))