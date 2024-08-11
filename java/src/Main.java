import java.nio.file.Files;
import java.nio.file.Paths;

public class Main {
    public static void main(String[] args) throws Exception {
        long start = System.nanoTime();
        String inputFile = getInputArg(args);
        if (inputFile == null) {
            throw new Exception("input file path not given");
        }

        final int[] linesAndChars = {0, 0};
        try (var stream = Files.lines(Paths.get(inputFile))) {
            stream.forEach(line -> {
                linesAndChars[0] += 1;
                linesAndChars[1] += line.length();
            });
        }
        long dur = System.nanoTime() - start;
        var durMs = dur / (1000.0 * 1000.0);
        System.out.printf("The input file contains %d lines of text and %d characters. The execution of this script took %f ms.", linesAndChars[0], linesAndChars[1], durMs);
    }

    private static String getInputArg(String[] args) {
        String inputFile = null;
        for (var i = 0; i < args.length; i++) {
            String arg = args[i];
            if (arg.equals("--input") || arg.equals("-i")) {
                if (args.length > i + 1) {
                    inputFile = args[i + 1];
                }
                break;
            }
            if (arg.startsWith("--input=")) {
                inputFile = arg.substring("--input=".length());
                break;
            }
            if (arg.startsWith("-i=")) {
                inputFile = arg.substring("-i=".length());
                break;
            }
        }

        return inputFile;
    }
}