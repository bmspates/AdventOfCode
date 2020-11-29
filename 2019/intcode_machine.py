import itertools

class IntcodeVM:

    POSITION_MODE = 0
    IMMEDIATE_MODE = 1
    RELATIVE_MODE = 2
    MAX_PARAMETERS = 3
    OPCODE_LENGTH = 2
    SUCCESS = 0
    TERM_WAIT = 1
    TERM_HALT = 2

    OP_ADD = 1
    OP_MULT = 2
    OP_IN = 3
    OP_OUT = 4
    OP_JIT = 5
    OP_JIF = 6
    OP_LT = 7
    OP_EQ = 8
    OP_ARB = 9

    MEMORY_SIZE = 2 ** 12

    # Maps the opcode to the length of it's corresponding instruction
    LEN_INSTRUCTIONS = {1: 4, 2: 4, 3: 2, 4: 2, 5 : 3, 6 : 3, 7 : 4, 8 : 4, 9 : 2}

    def __init__(self, data, input_, output = []):
        self.data = data
        self.data.extend(itertools.repeat(0, IntcodeVM.MEMORY_SIZE - len(self.data)))
        self.input_ = input_
        self.output = output
        self.index = 0
        self.input_num = 0
        self.relative_base = 0

    def step(self):
        instruction = self.data[self.index]
        opcode = instruction % 100
        if opcode == 99:
            return IntcodeVM.TERM_HALT

        num_params = IntcodeVM.LEN_INSTRUCTIONS[opcode] - 1
        parameter_modes = str(instruction)[:-IntcodeVM.OPCODE_LENGTH] 
        # Pads the parameter_modes with 0's to account for leading zeroes omission
        parameter_modes = ('0' * (num_params - len(parameter_modes))) + parameter_modes
        parameter_modes = [ int(char) for char in parameter_modes ]
        parameter_modes.reverse()
        args = [ self.data[self.index + i] for i in range(1, num_params + 1) ]
        params = []
        jump = False
        out_addr = 0
        # TODO If this is used more in the future handle params better, I hadn't planned on the addition of more modes and this is a bit messy
        for i, mode in enumerate(parameter_modes):
            if opcode in [IntcodeVM.OP_IN] or (i == 2 and opcode in [IntcodeVM.OP_ADD, IntcodeVM.OP_MULT, IntcodeVM.OP_LT, IntcodeVM.OP_EQ]):
                if mode == IntcodeVM.POSITION_MODE:
                    out_addr = args[i]
                elif mode == IntcodeVM.RELATIVE_MODE: 
                    out_addr = args[i] + self.relative_base
            if mode == IntcodeVM.POSITION_MODE: # 0 
                params.append(self.data[args[i]])
            elif mode == IntcodeVM.IMMEDIATE_MODE: # 1
                params.append(args[i])
            elif mode == IntcodeVM.RELATIVE_MODE: # 2
                params.append(self.data[self.relative_base + args[i]])

        if opcode == IntcodeVM.OP_ADD: # Add
            self.data[out_addr] = params[0] + params[1]

        elif opcode == IntcodeVM.OP_MULT: # Multiply
            self.data[out_addr] = params[0] * params[1]

        elif opcode == IntcodeVM.OP_IN: # Input
            while self.input_num >= len(self.input_):
                return IntcodeVM.TERM_WAIT
            self.data[out_addr] = self.input_[self.input_num]
            self.input_num += 1

        elif opcode == IntcodeVM.OP_OUT: # Output
            self.output.append(params[0])

        elif opcode == IntcodeVM.OP_JIT: # Jump If True
            if params[0] != 0:
                self.index = params[1]
                jump = True

        elif opcode == IntcodeVM.OP_JIF: # Jump If False
            if params[0] == 0:
                self.index = params[1]
                jump = True

        elif opcode == IntcodeVM.OP_LT: # Less Than
            self.data[out_addr] = 1 if params[0] < params[1] else 0

        elif opcode == IntcodeVM.OP_EQ: # Equal To
            self.data[out_addr] = 1 if params[0] == params[1] else 0

        elif opcode == IntcodeVM.OP_ARB: # Adjust Relative Base
            self.relative_base += params[0]

        if not jump:
            self.index += IntcodeVM.LEN_INSTRUCTIONS[opcode]
        return IntcodeVM.SUCCESS

    def run(self):
        while True:
            result = self.step()
            if result == IntcodeVM.TERM_HALT:
                break
            if result == IntcodeVM.TERM_WAIT:
                pass
        return self.output[-1]

    def testrun(self):
        self.run()
        if not all(out == 0 for out in self.output[:-1]):
            print("Malfunctioning Opcodes Deteceted.")
