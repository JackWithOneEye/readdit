package main

import "core:bufio"
import "core:flags"
import "core:fmt"
import "core:os"
import "core:time"

main :: proc() {
	start := time.tick_now()

	lines, chars := readdit()

	end := time.tick_now()
	dur := time.duration_milliseconds(time.tick_diff(start, end))

	fmt.printfln(
		"The input file contains %d lines of text and %d characters. The execution of this script took %f ms.",
		lines,
		chars,
		dur,
	)
}

readdit :: proc() -> (lines, chars: int) {
	Options :: struct {
		input: os.Handle `args:"pos=0,required,file=r" usage:"Input file"`,
	}

	opt: Options
	style: flags.Parsing_Style = .Unix
	flags.parse_or_exit(&opt, os.args, style)
	defer os.close(opt.input)

	r: bufio.Reader
	bufio.reader_init(&r, os.stream_from_handle(opt.input))
	defer bufio.reader_destroy(&r)

	for {
		line := bufio.reader_read_string(&r, '\n') or_break
		defer delete(line)
		lines += 1
		chars += len(line)
	}

	return lines, chars
}
