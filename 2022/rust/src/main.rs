mod lib;
mod days;

use lib::solution::*;

use days::{day01, day02, day03, day05, day10};
use std::env;
use std::time::Duration;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        panic!("Please provide the day(s) to run as a command-line argument");
    }

    let days: Vec<u8> = args[1..].iter()
        .map(|x| x.parse().unwrap_or_else(|v| panic!("Not a valid day: {}", v)))
        .collect();

    println!("{:?}", days);

    let mut runtime: Duration = Duration::from_secs(0);

    for day in days {
        let solution: SolutionPair = get_solution(day);
        let duration = solution.duration_one + solution.duration_two;

        println!("\n===Day {:02}===", day);
        println!("- Part One: {}", solution.part_one);
        println!("  - Duration: {:?}", solution.duration_one);
        println!("- Part Two: {}", solution.part_two);
        println!("  - Duration: {:?}", solution.duration_two);
        println!("- Runtime: {:?}", duration);

        runtime += duration;
    }
    
    println!("\nTotal Runtime: {:?}", runtime);
}

fn get_solution(day: u8) -> SolutionPair {
    match day {
        1 => day01::solve(),
        2 => day02::solve(),
        3 => day03::solve(),
        5 => day05::solve(),
        10 => day10::solve(),
        _ => unimplemented!(),
    }
}
