use crate::lib::solution::Solution;
use crate::lib::solution::SolutionPair;

use std::fs::read_to_string;
use std::time::Instant;

pub fn solve() -> SolutionPair {
    let input: String = read_to_string("inputs/day01.txt").unwrap();

    // Part One
    let mut start = Instant::now();
    let mut calories: Vec<u32> = input.split("\n\n").map(
        |ls| ls.split("\n").map(|x| x.parse::<u32>().unwrap_or_default()).sum()
    ).collect();
    calories.sort();
    let l = calories.len();

    let part_one = Solution::U32(calories[l - 1]);
    // Part One End
    let duration_one = start.elapsed();

    // Part Two
    start = Instant::now();

    let part_two = Solution::U32(calories[l - 3 .. l].iter().sum());
    // Part Two End
    let duration_two = start.elapsed();
    
    SolutionPair { part_one, part_two, duration_one, duration_two }
}
