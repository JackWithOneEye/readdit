package main

import (
	"bufio"
	"flag"
	"log"
	"os"
	"time"
)

func main() {
	start := time.Now()

	var inputFile string
	flag.StringVar(&inputFile, "input", "", "input file path")
	flag.Parse()

	if len(inputFile) == 0 {
		log.Fatalf("input file argument not given")
	}

	file, err := os.Open(inputFile)

	if err != nil {
		log.Fatalf("could not open file: %v", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	lines := 0
	chars := 0
	for scanner.Scan() {
		lines += 1
		chars += len(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("error reading file: %v", err)
	}

	dur := time.Since(start).Microseconds()
	durMs := float64(dur) / 1e3
	log.Printf("The input file contains %d lines of text and %d characters. The execution of this script took %f ms", lines, chars, durMs)
}
