import Foundation

func writeResults(_ results: SimulationResults) {
    let dir = "/Users/piotr/Code/Xcode/StardewValleySim/Results/"
    let filename = ISO8601DateFormatter.string(from: Date(),
                                               timeZone: .autoupdatingCurrent,
                                               formatOptions: [.withYear, .withMonth, .withDay, .withTime])

    let pathSummary = "\(dir)/\(filename).tsv"
    FileManager.default.createFile(atPath: pathSummary, contents: nil, attributes: nil)
    let outputSummary = FileHandle(forUpdatingAtPath: pathSummary)!

    let pathFullResults = "\(dir)/\(filename).txt"
    FileManager.default.createFile(atPath: pathFullResults, contents: nil, attributes: nil)
    let outputFullResults = FileHandle(forUpdatingAtPath: pathFullResults)!

    for (index, state) in results.reversed().enumerated() {
        outputSummary.write("\(index + 1)\t\(state.gold)\t\(state.wateringCost)\n".data(using: .utf8)!)
        outputFullResults.write("#\(index + 1)\n\(state)\n".data(using: .utf8)!)
    }
}
