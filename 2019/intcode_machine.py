POSITION_MODE = 0
IMMEDIATE_MODE = 1
MAX_PARAMETERS = 3
OPCODE_LENGTH = 2
# Maps the opcode to the length of it's corresponding instruction
LEN_INSTRUCTIONS = {1: 4, 2: 4, 3: 2, 4: 2, 5 : 3, 6 : 3, 7 : 4, 8 : 4}


def run(data, input_):
    index = 0
    output = []
    while data[index] != 99:
        opcode = data[index] % 100
        num_params = LEN_INSTRUCTIONS[opcode] - 1
        parameter_modes = str(data[index])[:-OPCODE_LENGTH]
        # Pads the parameter_modes with 0's to account for leading zeroes omission
        parameter_modes = ('0' * (num_params - len(parameter_modes))) + parameter_modes
        parameter_modes = [ int(char) for char in parameter_modes ]
        parameter_modes.reverse()
        args = [ data[index + i] for i in range(1, num_params + 1) ]
        params = []
        jump = False
        for i in range(len(args)):
            params.append(data[args[i]] if parameter_modes[i] == POSITION_MODE else args[i])
        if opcode == 1: # Add
            data[args[2]] = params[0] + params[1]
        elif opcode == 2: # Multiply
            data[args[2]] = params[0] * params[1]
        elif opcode == 3: # Input
            data[args[0]] = input_
        elif opcode == 4: # Output
            output.append(params[0])
        elif opcode == 5: # Jump If True
            if params[0] != 0:
                index = params[1]
                jump = True
        elif opcode == 6: # Jump If False
            if params[0] == 0:
                index = params[1]
                jump = True
        elif opcode == 7: # Less Than
            data[args[2]] = 1 if params[0] < params[1] else 0
        elif opcode == 8: # Equal To
            data[args[2]] = 1 if params[0] == params[1] else 0
        if not jump:
            index += LEN_INSTRUCTIONS[opcode]
    if not all(out == 0 for out in output[:-1]):
        print("An error occurred")
    return output[-1]
