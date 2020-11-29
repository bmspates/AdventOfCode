import fileinput
import itertools

def intcode_machine(data):
    index = 0
    while data[index] != 99:
        opcode = data[index]
        args = [ data[index + 1], data[index + 2], data[index + 3] ] 
        if opcode == 1:
            data[args[2]] = data[args[0]] + data[args[1]]
        elif opcode == 2:
            data[args[2]] = data[args[0]] * data[args[1]]
        index += 4
    return data


data = [ int(num) for num in fileinput.input()[0].split(',') ]
data_p1 = data.copy()

data_p1[1] = 12
data_p1[2] = 2

print(intcode_machine(data_p1)[0])

for arg0, arg1 in itertools.product(range(100), range(100)):
    data_p2 = data.copy()
    data_p2[1] = arg0
    data_p2[2] = arg1
    if (intcode_machine(data_p2)[0] == 19690720):
        print(100 * arg0 + arg1)
        break
