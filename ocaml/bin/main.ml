open Base
open Stdio

let usage_msg = "ocaml --input <input>"
let input_file = ref ""
let speclist = [ "--input", Stdlib.Arg.Set_string input_file, "input file path" ]

let result_fmt =
  Printf.sprintf
    "The input file contains %d lines of text and %d characters. The execution of this \
     script took %f ms"
;;

let () =
  let start = Unix.gettimeofday () in
  Stdlib.Arg.parse speclist (fun _ -> ()) usage_msg;
  let read_lines chan =
    let rec loop_lines lines chars =
      match In_channel.input_line chan with
      | Some line -> loop_lines (lines + 1) (line |> String.length |> ( + ) chars)
      | None -> lines, chars
    in
    loop_lines 0 0
  in
  let lines, chars = In_channel.with_file !input_file ~f:read_lines in
  let fin = Unix.gettimeofday () in
  let dur = (fin -. start) *. 1000.0 in
  result_fmt lines chars dur |> print_endline
;;
