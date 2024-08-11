import ArgumentParser
import Foundation

@available(macOS 12.0, *)
@main
struct Readdit: AsyncParsableCommand {
  @Option(name: .shortAndLong, help: "input file path")
  var inputFile: String

  func run() async throws {
    let start = CFAbsoluteTimeGetCurrent()
    let fileURL = URL(fileURLWithPath: inputFile)

    var lines = 0
    var chars = 0
    for try await line in fileURL.lines {
      lines += 1
      chars += line.lengthOfBytes(using: String.Encoding.utf8)
    }

    let dur = CFAbsoluteTimeGetCurrent() - start
    let durMs = round(dur * 1000 * 100) / 100
    print(
      "The input file contains \(lines) lines of text and \(chars) characters. The execution of this script took \(durMs) ms."
    )
  }
}
