use crate::lib::solution::Solution;
use crate::lib::solution::SolutionPair;

use std::fs::read_to_string;
use std::time::Instant;

pub fn solve() -> SolutionPair {
    let input: String = read_to_string("inputs/dayXX.txt").unwrap();

    // Part One
    let mut start = Instant::now();
    let part_one = Solution::U32(0);

    // Part One End
    let duration_one = start.elapsed();

    // Part Two
    start = Instant::now();

    let part_two = Solution::U32(0);

    // Part Two End
    let duration_two = start.elapsed();
    
    SolutionPair { part_one, part_two, duration_one, duration_two }
}
