import fileinput, intcode_machine

data = [ line.strip() for line in open("inputs/day5.txt", 'r') ]
data = data[0].split(',')
data = [ int(num) for num in data ]

output = intcode_machine.run(data.copy(), 1)
print(output)
output = intcode_machine.run(data.copy(), 5)
print(output)
