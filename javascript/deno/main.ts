import { parseArgs } from "jsr:@std/cli/parse-args";
import { assert } from "jsr:@std/assert";

const start = performance.now();

const { input } = parseArgs(Deno.args, {
  string: ["input"],
});

assert(input, 'input file argument not given');

using file = Deno.openSync(input, { read: true });
const fileInfo = file.statSync();

assert(fileInfo.isFile, 'input file must not be a directory');

const buf = new Uint8Array(1024);
const decoder = new TextDecoder();
let lines = 0;
let chars = 0;
let lineBuffer = '';

while (file.readSync(buf) != null) {
  const chunk = decoder.decode(buf, { stream: true });
  if (chunk.length === 0) {
    continue;
  }
  lineBuffer += chunk;
  const split = lineBuffer.split('\n');
  const last = split.pop();
  if (last) {
    lineBuffer = last;
  }
  lines += split.length;
  for (const line of split) {
    chars += line.length;
  }
}

const end = performance.now();
const dur = Math.round((end - start) * 100) / 100
console.log(`The input file contains ${lines} lines of text and ${chars} characters. The execution of this script took ${dur.toFixed(2)} ms.`);