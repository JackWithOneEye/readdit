start = time_ns()

input_file = ""

if ARGS[1] == "--input" || ARGS[1] == "-i"
    input_file = ARGS[2]
end

if length(input_file) == 0
    error("input file path not given")
end

file = open(input_file, read=true)

lines = 0
chars = 0
for line in eachline(file)
    global lines += 1
    global chars += length(line)
end

close(file)

dur = round((time_ns() - start) / 1e6 * 100) / 100

println("The input file contains ", lines, " lines of text and ", chars, " characters. The execution of this script took ", dur, " ms.")
