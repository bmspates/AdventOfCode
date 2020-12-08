class VirtualMachine:
    
    OP_ACC = "acc"
    OP_JUMP = "jmp"
    NOP = "nop"

    SUCCESS = 0
    REPEAT_INSTRUCTION = 1
    INFINITE_LOOP = -1

    def __init__(self, data):
        self.accumulator = 0
        self.data = data
        self.IP = 0
        self.processed = set()
        self.icount = 0

    def step(self):
        instruction = self.data[self.IP][0]
        param = self.data[self.IP][1]
        jump = False
        if self.IP in self.processed:
            pass
            # return VirtualMachine.REPEAT_INSTRUCTION
        self.processed.add(self.IP)
        if instruction == VirtualMachine.OP_ACC:
            self.accumulator += param
        elif instruction == VirtualMachine.OP_JUMP:
            self.IP += param
            jump = True
        elif instruction == VirtualMachine.NOP:
            pass
        if not jump:
            self.IP += 1
        return VirtualMachine.SUCCESS
    
    def run(self):
        while True:
            prev_IP = self.IP
            result = self.step()
            if prev_IP == self.IP or self.icount > 10000:
                return VirtualMachine.INFINITE_LOOP
            if result == VirtualMachine.REPEAT_INSTRUCTION:
                break
            if self.IP == len(self.data):
                break
            self.icount += 1
        return self.accumulator