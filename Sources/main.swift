import Foundation



private let energyAllowance = 250.0
private let wateringEnergyPerPlot = 2.0 // 1.33 copper, 1.20 iron, 0.89 gold, 0.56 iridium
let MAX_PLOTS = UInt(energyAllowance / wateringEnergyPerPlot)

let STARTING_DAY: UInt = 1
let STARTING_GOLD: UInt = 500
let STARTING_PLANTATIONS: [Plantation] = [
    Plantation(crop: parsnip, amount: 15, dayPlanted: 1), // start-of-game-parsnip
]

let STARTING_STATE = SimulationState(parentState: nil,
                                     day: STARTING_DAY,
                                     plantations: STARTING_PLANTATIONS,
                                     gold: STARTING_GOLD,
                                     nextDay: STARTING_DAY)

let RESULTS_LIMIT = 1000

let OPERATIONS_COUNT: Int = {
    if CommandLine.argc > 1, let value = Int(CommandLine.arguments[1]), value > 0 {
        return value
    } else {
        return 100
    }
}()
print("operationsCount = \(formatNumber(OPERATIONS_COUNT))")

let results = performSimulation()
writeResults(results)
