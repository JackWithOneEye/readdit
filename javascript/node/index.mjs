import { strict as assert } from 'assert';
import * as fs from 'fs';
import * as readline from 'readline';
import { parseArgs } from 'util';

const start = performance.now();

const { values } = parseArgs({
    args: process.argv,
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

fs.stat(inputFile, (err, stats) => {
    assert.ifError(err);
    assert.ok(stats.isFile(), 'input file must not be a directory')
    processFile(inputFile);
});

/**
 * @param {string} inputFilePath 
 */
function processFile(inputFilePath) {
    const stream = fs.createReadStream(inputFilePath);
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
}