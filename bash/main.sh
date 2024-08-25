#!/bin/bash

while getopts "i:" flag; do
 case $flag in
   i)
   input_file=$OPTARG
   ;;
   \?)
   echo "Unknown option: $flag"
   exit 1
   ;;
 esac
done

if [ ! -f $input_file ]; then
  echo "file $input_file does not exist"
  exit 1
fi

lines=0
chars=0

while read -r line; do
  lines=$((lines + 1))
  chars=$((chars + ${#line}))
done < $input_file

echo "The input file contains $lines lines of text and $chars characters. The execution of this script took ? ms."