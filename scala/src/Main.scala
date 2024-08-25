import io.Source

@main
def main(inputFile: String): Unit = {
  val start = System.nanoTime()

  val src = Source.fromFile(inputFile)
  var lines = 0
  var chars = 0
  for (line <- src.getLines())
    lines += 1
    chars += line.length
  src.close()

  val end = System.nanoTime()
  val dur = (end - start) / 1e6
  println(s"The input file contains $lines lines of text and $chars characters. The execution of this script took $dur ms.")
}

