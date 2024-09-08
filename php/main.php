<?php
$start = microtime(true);

$options = getopt("i:", ["input:"]);

$input_file = match (true) {
    isset($options["i"]) => $options["i"],
    isset($options["input"]) => $options["input"],
    default => throw new Error("input file path not given!")
};

$file_handle = fopen($input_file, "r");
if (!$file_handle) {
    throw new Error("input file does not exist!");
}

$lines = 0;
$chars = 0;
try {
    while (($line = fgets($file_handle)) !== false) {
        $lines += 1;
        $chars += strlen($line);
    }
} finally {
    fclose($file_handle);
}

$end = microtime(true);
$dur = round(($end - $start) * 1e3 * 100) / 100;

echo "The input file contains $lines lines of text and $chars characters. The execution of this script took $dur ms.\n";
