import fileinput
from intcode_machine import IntcodeVM as iVM

data = [ line.strip() for line in open("inputs/day9.txt", 'r') ]
# data = [ line.strip() for line in open("inputs/tests/9.txt", 'r') ]
data = data[0].split(',') # 0 : -1, 1 : 1, 2 : 109, 3 : 204, 4 : 204, 5 : 204, 6 : input, 7 : input
data = [ int(num) for num in data]
vm = iVM(data.copy(), (2,))
vm.testrun()
print(vm.output)