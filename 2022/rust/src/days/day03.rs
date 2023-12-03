use crate::lib::solution::Solution;
use crate::lib::solution::SolutionPair;

use std::fs::read_to_string;
use std::time::Instant;

fn get_priority(x: char) -> u32 {
    if x.is_uppercase() { x as u32  - 64 } else { x as u32 - 96 }
}

fn find_common_chars(mut ls: Vec<String>) -> String  {
    let mut out = ls.pop().unwrap();
    for x in ls {
        out.retain(|z| x.contains(z));
    }
    out.to_string()
}

pub fn solve() -> SolutionPair {
    let input: String = read_to_string("inputs/day03.txt").unwrap();

    // Part One
    let mut start = Instant::now();

    let halves: Vec<Vec<String>> = input.clone().split("\n").map(|x| {
        let len = x.len();
        let lhs = x;
        let rhs = x.to_string().split_off(len / 2);
        let mut vec = Vec::new();
        vec.push(lhs.to_string());
        vec.push(rhs.to_string());
        vec
    }).collect();
    

    let part_one = Solution::U32(halves.iter().map(|h| {
        get_priority(find_common_chars(h.to_vec()).chars().nth(0).unwrap())
    }).sum());

    // Part One End
    let duration_one = start.elapsed();

    // Part Two
    start = Instant::now();

    let part_two = Solution::U32(0);

    // Part Two End
    let duration_two = start.elapsed();
    
    SolutionPair { part_one, part_two, duration_one, duration_two }
}
