import fileinput, itertools
from intcode_machine import IntcodeVM

# TODO reduce redundancy if I ever clean this up

NUM_VMS = 5

data = [ line.strip() for line in open("inputs/day7.txt", 'r') ]
data = data[0].split(',')
data = [ int(num) for num in data ]

possible_outputs = set()
for combo in itertools.permutations('01234', 5):
    phases = [ int(char) for char in combo ]
    outputs = [0]
    for i in range(5):
        vm = IntcodeVM(data.copy(), (phases[i], outputs[i]), [])
        outputs.append(vm.run())
    possible_outputs.add(outputs[-1])
print("Part One: " + str(max(possible_outputs)))

possible_outputs = set()
for combo in itertools.permutations("56789", 5):
    phases = [ int(char) for char in combo ]
    inputs = [ [] for _ in range(NUM_VMS) ]
    vms = []
    vm_num = itertools.cycle(range(NUM_VMS))
    for i in range(NUM_VMS):
        inputs[i].append(phases[i])
        out = i + 1 if i != NUM_VMS - 1 else 0
        vms.append(IntcodeVM(data.copy(), inputs[i], inputs[out]))
    inputs[0].append(0)
    while True:
        curr_vm = next(vm_num)
        status = IntcodeVM.SUCCESS
        while status == IntcodeVM.SUCCESS:
            status = vms[curr_vm].step()
        if curr_vm == NUM_VMS - 1 and status == IntcodeVM.TERM_HALT:
            possible_outputs.add(vms[curr_vm].output[-1])
            break
print("Part Two: " + str(max(possible_outputs)))