/* Instruction Format (32 bits)
        Opcode (6 bit) Types:
            XXXX00: A Type
            XXXX01: B Type
        A Type Instctions:
            000000: noop
        B Type Instructions:
            000001: addx

        Fixed Instruction Format:
            0-5: Opcode
            6-12: Destination Register
        A Type Format:
            13-19: Source Register 1
            20-26: Source Register 2
            27-31: Unused
        B Type Format: 
            13-28: Immediate (16 Bits)
            29-31: Unused

*/

const INSTRUCTION_COUNT: usize = 4096 as usize;
const MEMORY_SIZE: usize = 0 as usize;

pub struct CPU {
    registers: [i32; 17], // 0: Constant 0, 1 - 16: General Purpose
    instructions: [u32; INSTRUCTION_COUNT],
    pc: u32, // Program Counter
    clock: u32, // Clock Cycle number
    // memory: [i32, MEMORY_SIZE]
}
impl CPU {
    fn fetch(&self) {

    }

    fn decode(&self) {

    }

    fn execute(&self) {

    }
}

impl CPU {
    pub fn cycle(&mut self) { // TODO: Implement pipelining later

    }

    pub fn initialize(instructions: Vec<String>) -> CPU {
        let mut inst_arr = [0; 4096];
        let mut registers = [0; 17];

        CPU { 
            registers: registers,
            instructions: inst_arr,
            pc: 0,
            clock: 0
        }
    }
}