import Foundation

let energyAllowance = 250.0
let wateringEnergyPerPlot = 2.0 // 1.33 copper, 1.20 iron, 0.89 gold, 0.56 iridium
let maxPlots = UInt(energyAllowance / wateringEnergyPerPlot)

let startingDay: UInt = 1
let startingGold: UInt = 500
let startingPlantations: [Plantation] = [
    Plantation(crop: parsnip, amount: 15, dayPlanted: 1), // start-of-game-parsnip
]

let startingState = SimulationState(parentState: nil,
                                    day: startingDay,
                                    plantations: startingPlantations,
                                    gold: startingGold,
                                    nextDay: startingDay)

let filename = ISO8601DateFormatter.string(from: Date(),
                                           timeZone: .autoupdatingCurrent,
                                           formatOptions: [.withYear, .withMonth, .withDay, .withTime])
let path = "/Users/piotr/Code/Xcode/StardewValleySim/Results/\(filename).txt"
FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
let output = FileHandle(forUpdatingAtPath: path)!

var count = 0

var results = BoundSortedCollection<SimulationState>(limit: 100,
                                                     areEqual: { $0.gold == $1.gold },
                                                     areInIncreasingOrder: { $0.gold < $1.gold})

var states = [startingState]
while let parentState = states.popLast() {
    count += 1
    generateSimulationBranches(parentState: parentState) { state in
        if state.nextDay == nil { results.insert(state) }
        else { states.append(state) }
    }
}

print("processed \(count) states")

for state in results {
    output.write("\(state)\n".data(using: .utf8)!)
}
