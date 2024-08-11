open Base
open Stdio

let usage_msg = "ocaml --input <input>"
let input_file = ref ""
let speclist = [ "--input", Stdlib.Arg.Set_string input_file, "input file path" ]

let result_fmt =
  Printf.sprintf
    {|The input file contains %d lines of text and %d characters. The execution of this script took %f ms.|}
;;

let () =
  let start = Unix.gettimeofday () in
  Stdlib.Arg.parse speclist (fun _ -> ()) usage_msg;
  let open In_channel in
  let lines, chars =
    with_file
      !input_file
      ~f:
        (fold_lines ~init:(0, 0) ~f:(fun (lines, chars) line ->
           lines + 1, chars + String.length line))
  in
  let fin = Unix.gettimeofday () in
  let dur = (fin -. start) *. 1000.0 in
  result_fmt lines chars dur |> print_endline
;;
