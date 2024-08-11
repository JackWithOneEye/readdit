import java.io.File
import kotlin.time.measureTime

fun main(args: Array<String>) {
    var lines = 0
    var chars = 0

    val timeTaken = measureTime {
        var inputFile: String? = null
        for (i in args.indices) {
            val arg = args[i]
            if (arg == "--input" || arg == "-i") {
                if (args.size > i + 1) {
                    inputFile = args[i + 1]
                }
                break
            }
            if (arg.startsWith("--input=")) {
                inputFile = arg.substring("--input=".length)
                break
            }
            if (arg.startsWith("-i=")) {
                inputFile = arg.substring("-i=".length)
                break
            }
        }

        val path = inputFile ?: throw Exception("input file path not given")

        File(path).inputStream().bufferedReader().use { reader ->
            reader.forEachLine { line ->
                lines += 1
                chars += line.length
            }
        }
    }

    println("The input file contains $lines lines of text and $chars characters. The execution of this script took ${timeTaken.inWholeMilliseconds} ms.")
}