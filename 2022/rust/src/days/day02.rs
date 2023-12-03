use crate::lib::solution::Solution;
use crate::lib::solution::SolutionPair;

use std::fs::read_to_string;
use std::time::Instant;

fn eval_game(op: &str, you: &str) -> u32  {
    match op {
        "A" => match you {
            "X" => 3, "Y" => 6, "Z" => 0, &_ => panic!()
        },
        "B" => match you {
            "X" => 0, "Y" => 3, "Z" => 6, &_ => panic!()
        },
        "C" => match you {
            "X" => 6, "Y" => 0,  "Z" => 3, &_ => panic!()
        },
        &_ => panic!()
    }
}

fn move_point(mv: &str) -> u32 {
    match mv {
        "X" => 1, "Y" => 2, "Z" => 3, &_ => panic!()
    }
}

fn response(mv : &str, win_cond: &str) -> String {
    match win_cond {
        "X" => match mv {
            "A" => "Z", "B" => "X", "C" => "Y", &_ => panic!()
        }.to_string(),
        "Y" => match mv {
            "A" => "X", "B" => "Y", "C" => "Z", &_ => panic!()
        }.to_string(),
        "Z" => match mv {
            "A" => "Y", "B" => "Z", "C" => "X", &_ => panic!()
        }.to_string(),
        &_ => panic!()
    }
}

fn process_input(input: String, f: fn(&str, &str) -> String) -> Vec<(String, String)> {
    input.split("\n").map(|s| {
        let mut split = s.split(" ");
        let op = split.next().unwrap();
        let you = f(&op, &split.next().unwrap());
        (op.to_string(), you)
    }).collect()
}

fn score_moves(moves: Vec<(String, String)>) -> u32 {
    moves.iter().map(|x| eval_game(&x.0, &x.1) + move_point(&x.1)).sum()
}


pub fn solve() -> SolutionPair {
    let input: String = read_to_string("inputs/day02.txt").unwrap();

    // Part One
    let mut start = Instant::now();
    let mut moves = process_input(input.clone(), |_x, y| y.to_string());
    let part_one = Solution::U32(score_moves(moves));

    // Part One End
    let duration_one = start.elapsed();

    // Part Two
    start = Instant::now();
    moves = process_input(input.clone(), response);
    let part_two = Solution::U32(score_moves(moves));

    // Part Two End
    let duration_two = start.elapsed();
    
    SolutionPair { part_one, part_two, duration_one, duration_two }
}
