class IntcodeVM:

    POSITION_MODE = 0
    IMMEDIATE_MODE = 1
    MAX_PARAMETERS = 3
    OPCODE_LENGTH = 2
    SUCCESS = 0
    TERM_WAIT = 1
    TERM_HALT = 2

    # Maps the opcode to the length of it's corresponding instruction
    LEN_INSTRUCTIONS = {1: 4, 2: 4, 3: 2, 4: 2, 5 : 3, 6 : 3, 7 : 4, 8 : 4}

    def __init__(self, data, input_, output = []):
        self.data = data
        self.input_ = input_
        self.output = output
        self.index = 0
        self.input_num = 0

    def step(self):
        opcode = self.data[self.index] % 100
        if opcode == 99:
            return IntcodeVM.TERM_HALT

        num_params = IntcodeVM.LEN_INSTRUCTIONS[opcode] - 1
        parameter_modes = str(self.data[self.index])[:-IntcodeVM.OPCODE_LENGTH]
        # Pads the parameter_modes with 0's to account for leading zeroes omission
        parameter_modes = ('0' * (num_params - len(parameter_modes))) + parameter_modes
        parameter_modes = [ int(char) for char in parameter_modes ]
        parameter_modes.reverse()
        args = [ self.data[self.index + i] for i in range(1, num_params + 1) ]
        params = []
        jump = False
        for i in range(len(args)):
            params.append(self.data[args[i]] if parameter_modes[i] == IntcodeVM.POSITION_MODE else args[i])
        if opcode == 1: # Add
            self.data[args[2]] = params[0] + params[1]
        elif opcode == 2: # Multiply
            self.data[args[2]] = params[0] * params[1]
        elif opcode == 3: # Input
            while self.input_num >= len(self.input_):
                return IntcodeVM.TERM_WAIT
            self.data[args[0]] = self.input_[self.input_num]
            self.input_num += 1
        elif opcode == 4: # Output
            self.output.append(params[0])
        elif opcode == 5: # Jump If True
            if params[0] != 0:
                self.index = params[1]
                jump = True
        elif opcode == 6: # Jump If False
            if params[0] == 0:
                self.index = params[1]
                jump = True
        elif opcode == 7: # Less Than
            self.data[args[2]] = 1 if params[0] < params[1] else 0
        elif opcode == 8: # Equal To
            self.data[args[2]] = 1 if params[0] == params[1] else 0
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
