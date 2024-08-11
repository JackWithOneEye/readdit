using System.Diagnostics;

var sw = new Stopwatch();
sw.Start();

string? inputFile = null;

for (int i = 0; i < args.Length; i++)
{
    var arg = args[i];
    if (arg.Equals("--input") || arg.Equals("-i"))
    {
        if (args.Length > i + 1)
        {
            inputFile = args[i + 1];
        }
        break;
    }

    if (arg.StartsWith("--input="))
    {
        inputFile = arg["--input=".Length..];
        break;
    }

    if (arg.StartsWith("-i="))
    {
        inputFile = arg["-i=".Length..];
        break;
    }
}

if (inputFile == null)
{
    throw new Exception("input file path not given");
}

var lineReader = File.ReadLines(inputFile);
var lines = 0;
var chars = 0;
foreach (var line in lineReader)
{
    lines += 1;
    chars += line.Length;
}
sw.Stop();

var durMs = sw.Elapsed.TotalMilliseconds.ToString("n2");

Console.WriteLine(
    string.Format(
        "The input file contains {0} lines of text and {1} characters. The execution of this script took {2} ms.", lines, chars, durMs
    )
);
