local start = os.clock()

local input_file = nil

if arg[1] == "--input" or arg[1] == "-i" then
    input_file = arg[2]
end

if not input_file then
    error("input file path not given")
end

local file = io.open(input_file, "r")

if not file then
    error(string.format("file \"%s\" not found", input_file))
end

local lines = 0
local chars = 0
for line in file:lines() do
    lines = lines + 1
    chars = chars + line:len()
end

file:close()

local dur = (os.clock() - start) * 1000

print(string.format(
    "The input file contains %d lines of text and %d characters. The execution of this script took %f ms.", lines, chars,
    dur))
