use anyhow::Result;
use clap::Parser;
use io::BufReader;
use std::{
    fs::File,
    io::{self, BufRead},
    time::SystemTime,
};

#[derive(Parser)]
struct Args {
    #[arg(short, long)]
    input: String,
}

fn main() -> Result<()> {
    let start = SystemTime::now();

    let Args { input } = Args::parse();
    let file = File::open(input)?;
    let reader = BufReader::new(file).lines();

    let mut lines = 0;
    let mut chars = 0;
    for line in reader.flatten() {
        lines += 1;
        chars += line.len();
    }

    let dur = start.elapsed()?.as_micros();
    let dur_ms = (dur as f64) / 1000.0;
    println!("The input file contains {lines} lines of text and {chars} characters. The execution of this script took {dur_ms} ms");

    Ok(())
}
