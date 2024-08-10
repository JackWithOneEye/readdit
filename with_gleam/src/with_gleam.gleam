import argv
import file_streams/file_stream.{type FileStream}
import file_streams/file_stream_error.{Eof}
import gleam/float
import gleam/int
import gleam/io
import gleam/string

pub fn main() {
  let start = now()

  let assert Ok(stream) =
    case argv.load().arguments {
      ["input", input_file] -> input_file
      ["i", input_file] -> input_file
      _ -> panic as "input file argument not given"
    }
    |> file_stream.open_read

  let #(lines, chars) = read_line_loop(stream, 0, 0)

  let end = now()

  let dur = int.to_float(end - start) /. 1000.0

  io.println(
    "The input file contains "
    <> int.to_string(lines)
    <> " lines of text and "
    <> int.to_string(chars)
    <> " characters. The execution of this script took "
    <> float.to_string(dur)
    <> " ms.",
  )
}

fn read_line_loop(stream: FileStream, lines: Int, chars: Int) {
  case file_stream.read_line(stream) {
    Ok(line) -> read_line_loop(stream, lines + 1, chars + string.length(line))
    Error(Eof) -> #(lines, chars)
    Error(_) -> panic
  }
}

@external(erlang, "now_ffi", "now")
fn now() -> Int
