use std::time::Duration;
use std::fmt::{Display, Formatter, Result};

pub enum Solution {
    Str(String),
    U8(u8),
    U32(u32),
    U64(u64),
    I32(i32),
    I64(i64),
}

impl Display for Solution {
    fn fmt(&self, f: &mut Formatter) -> Result {
        match self {
            Solution::Str(x) => x.fmt(f),
            Solution::U8(x) => x.fmt(f),
            Solution::U32(x) => x.fmt(f),
            Solution::U64(x) => x.fmt(f),
            Solution::I32(x) => x.fmt(f),
            Solution::I64(x) => x.fmt(f),
        }
    }
}

pub struct SolutionPair {
    pub part_one: Solution,
    pub part_two: Solution,
    pub duration_one: Duration,
    pub duration_two: Duration,
}
