import { strict as assert } from 'node:assert';
import * as fs from 'node:fs';
import * as readline from 'node:readline'
import { parseArgs } from 'node:util';

const start = performance.now();

const { values } = parseArgs({
    args: Bun.argv,
    options: {
        input: {
            type: 'string'
        }
    },
    strict: true,
    allowPositionals: true
});

const inputFile = values.input;
assert.ok(inputFile, 'input file argument not given');

const stats = fs.statSync(inputFile);
assert.ok(stats.isFile(), 'input file must not be a directory');

const stream = fs.createReadStream(inputFile);

const rl = readline.createInterface({
    input: stream,
    crlfDelay: Infinity
});

let lines = 0;
let chars = 0;

rl.on('line', (line) => {
    lines++;
    chars += line.length;
});

rl.on('close', () => {
    const end = performance.now();
    const dur = Math.round((end - start) * 100) / 100
    console.log(`The input file contains ${lines} lines of text and ${chars} characters. The execution of this script took ${dur.toFixed(2)} ms.`);
});
