use crate::lib::solution::Solution;
use crate::lib::solution::SolutionPair;

use std::fs::read_to_string;
use std::time::Instant;
use regex::Regex;

type Stack = Vec<char>;
type Move = (u8, u8, u8);

fn process_input(input: String) -> (Vec<Stack>, Vec<Move>) {
    let mut stacks: Vec<Stack> = Vec::new();
    let mut moves: Vec<Move> = Vec::new();
    for _ in 0..10 {
        stacks.push(Vec::new());
    }
    let mut split = input.split("\n\n");
    let group_one = split.next().unwrap().split("\n");
    for line in group_one {
        if line.contains("[") {
            for x in 0..10 {
                let i = (x * 4) + 1;
                let mut chars = line.chars();
                let c = chars.nth(i);

                if c.is_some() && c.unwrap() != ' ' {
                    stacks[x].insert(0, c.unwrap());
                }
            }
        }
    }

    let group_two = split.next().unwrap().split("\n");
    for line in group_two {
        let re = Regex::new(r"^move (\d*) from (\d*) to (\d*)").unwrap();
        for cap in re.captures_iter(line) {
            moves.push((cap[1].parse::<u8>().unwrap(), 
                                        cap[2].parse::<u8>().unwrap(), 
                                        cap[3].parse::<u8>().unwrap()));
        }

    }

    (stacks, moves)
}

fn crate_message(stacks: Vec<Vec<char>>) -> String {
    let mut message: String = "".to_string();
    for stack in stacks.iter() {
        let top_element = stack.last();
        if top_element.is_some() {
            message.push(*top_element.unwrap());
        }
    }
    message
}

fn print_stacks(stacks: Vec<Vec<char>>) {
    for stack in stacks.iter() {
        for char in stack.iter() {
            print!("{:?}", char);
        }
        println!("");
    }
}

pub fn solve() -> SolutionPair {
    let input: String = read_to_string("inputs/day05.txt").unwrap();

    // Part One
    let mut start = Instant::now();
    let (mut stacks, moves) = process_input(input);
    let stack_backup = stacks.clone();

    for mv in moves.iter() {
        for _ in 0..mv.0 {
            let item = stacks[(mv.1 as usize) - 1].pop().unwrap();
            stacks[(mv.2 as usize) - 1].push(item);
        }
    }

    let part_one = Solution::Str(crate_message(stacks.clone()));

    // Part One End
    let duration_one = start.elapsed();
    
    // Part Two
    start = Instant::now();

    stacks = stack_backup.clone();

    for mv in moves.iter() {
        let from_num = (mv.1 as usize) - 1;
        if !stacks[from_num].is_empty() {
            println!("{:?}", mv);
            let split_num = stacks[from_num].len().saturating_sub((mv.0) as usize);
            let mut pile = stacks[from_num].split_off(split_num);
            println!("Pile: {:?}", pile);
            stacks[(mv.2 as usize) - 1].append(&mut pile);
            print_stacks(stacks.clone());
        }
    }
    
    let part_two = Solution::Str(crate_message(stacks.clone()));

    // Part Two End
    let duration_two = start.elapsed();
    
    SolutionPair { part_one, part_two, duration_one, duration_two }
}
