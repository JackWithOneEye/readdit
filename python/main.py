from argparse import ArgumentParser
from time import perf_counter_ns

start = perf_counter_ns() 

parser = ArgumentParser('readdit')
parser.add_argument('--input', type=str, required=True)
args = parser.parse_args()

lines = 0
chars = 0
with open(args.input, mode="r") as file:
    while line := file.readline():
        lines += 1
        chars += len(line.strip('\n'))

end = perf_counter_ns()
dur = round((end - start) / 1e6 * 100) / 100
print("The input file contains {} lines of text and {} characters. The execution of this script took {} ms.".format(lines, chars, dur))