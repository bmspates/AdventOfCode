import fileinput
import math

data = [ int(line.strip()) for line in fileinput.input() ]

fuel_needed = sum([ math.floor(num / 3) - 2 for num in data ])
print(fuel_needed)

total_fuel = 0
for num in data:
    fuel = num
    while fuel != 0:
        fuel = max(math.floor(fuel / 3) - 2, 0)
        total_fuel += fuel
print(total_fuel)
