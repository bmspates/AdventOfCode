import fileinput, intcode_machine

data = [ line.strip() for line in open("inputs/day5.txt", 'r') ]
data = data[0].split(',')
data = [ int(num) for num in data ]

vm = intcode_machine.IntcodeVM(data.copy(), (1,), [])
print(vm.run())
vm = intcode_machine.IntcodeVM(data.copy(), (5,), [])
print(vm.run())
