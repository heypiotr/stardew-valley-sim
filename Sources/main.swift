import Foundation

private let operationsCount: Int = {
    if CommandLine.argc > 1, let value = Int(CommandLine.arguments[1]), value > 0 {
        return value
    } else {
        return OPERATIONS_COUNT
    }
}()
print("operationsCount = \(formatNumber(operationsCount))")

let results = performSimulation(operationsCount: operationsCount)
writeResults(results)
