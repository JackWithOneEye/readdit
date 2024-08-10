import std/[math, os, strformat, strutils, times]

type
    InvalidArgument = object of Defect

proc main =
    let start = cpuTime()

    let params = commandLineParams()
    var inputFile: string
    for n in 0 ..< params.len:
        let param = params[n]

        if param == "--input" or param == "-i":
            if params.len <= n+1:
                raise newException(InvalidArgument, "invalid argument")
            inputFile = params[n+1]
            break

        if startsWith(param, "--input="):
            inputFile = param["--input=".len .. ^1]
            break

        if startsWith(param, "-i="):
            inputFile = param["-i=".len .. ^1]
            break

    if inputFile.len == 0:
        raise newException(InvalidArgument, "input file argument not given")

    let file = open(inputFile)
    defer: file.close()

    var line: string
    var lines = 0
    var chars = 0
    while file.readLine(line):
        lines += 1
        chars += line.len

    let fin = cpuTime()
    let dur = round((fin - start) * 1000 * 100) / 100
    echo fmt"The input file contains {lines} lines of text and {chars} characters. The execution of this script took {dur} ms"

main()
