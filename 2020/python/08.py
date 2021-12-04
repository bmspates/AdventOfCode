# import itertools, numpy
from vm import VirtualMachine

def part_one(data):
    vm = VirtualMachine(data)
    return vm.run()

def part_two(data):
    to_check = []
    master = data
    for i, instruction in enumerate(data):
        if instruction[0] == VirtualMachine.OP_JUMP or instruction[0] == VirtualMachine.NOP:
            to_check.append(i)
    for i in to_check:
        data = master.copy()
        instruction = data[i][0]
        data[i] = (VirtualMachine.OP_JUMP if instruction == VirtualMachine.NOP else VirtualMachine.NOP, data[i][1])
        vm = VirtualMachine(data)
        result = vm.run()
        if result != VirtualMachine.INFINITE_LOOP:
            return result



data = [ line.strip() for line in open("../inputs/day8.txt", 'r') ]
# data = [ line.strip() for line in open("../inputs/tests/08.txt", 'r') ]

instructions = []
for line in data:
    split = line.split(' ')
    instructions.append((split[0], int(split[1])))

# print(part_one(instructions.copy()))
print(part_two(instructions.copy()))