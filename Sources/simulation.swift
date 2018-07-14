class SimulationState: CustomStringConvertible, Comparable {
    static func < (lhs: SimulationState, rhs: SimulationState) -> Bool {
        return lhs.gold < rhs.gold
    }

    static func == (lhs: SimulationState, rhs: SimulationState) -> Bool {
        return lhs.gold == rhs.gold
    }

    let parentState: SimulationState?

    let day: UInt
    let plantations: [Plantation]
    let gold: UInt

    let harvestedPlantations: [Plantation]
    let plantedPlantations: [Plantation]

    let nextDay: UInt?

    init(parentState: SimulationState?,

         day: UInt,
         plantations: [Plantation],
         gold: UInt,

         harvestedPlantations: [Plantation] = [],
         plantedPlantations: [Plantation] = [],

         nextDay: UInt?) {

        self.parentState = parentState

        self.day = day
        self.plantations = plantations
        self.gold = gold

        self.harvestedPlantations = harvestedPlantations
        self.plantedPlantations = plantedPlantations

        self.nextDay = nextDay
    }

    convenience init(parentState: SimulationState?,

                     day: UInt,
                     plantations: [Plantation],
                     gold: UInt,

                     harvestedPlantations: [Plantation] = [],
                     plantedPlantations: [Plantation] = []) {

        self.init(parentState: parentState,
                  day: day, plantations: plantations, gold: gold,
                  harvestedPlantations: harvestedPlantations, plantedPlantations: plantedPlantations,
                  nextDay: plantations.nextHarvestDay(afterDay: day))
    }

    lazy var description: String = {
        var result = ""

        if let parentState = parentState {
            result.append(parentState.description)
        }

        result.append(String(format: "D%02d\n", day))
        if !harvestedPlantations.isEmpty {
            result.append(" H \(harvestedPlantations)\n")
        }
        if !plantedPlantations.isEmpty {
            result.append(" P \(plantedPlantations)\n")
        }
        result.append(" A \(plantations)\n=> \(gold)g\n")
        if nextDay == nil {
            result.append("=> total watering cost = \(wateringCost)\n")
        }

        return result
    }()

    lazy var wateringCost: UInt = {
        var result: UInt = 0
        var state: SimulationState? = self
        repeat {
            result += state!.plantedPlantations.wateringCost
            state = state!.parentState
        } while state != nil
        return result
    }()
}

func generateSimulationBranches(parentState: SimulationState, callback: (SimulationState) -> Void) {
    guard let day = parentState.nextDay else { return }

    var harvestedPlantations = [Plantation]()
    var remainingPlantations = [Plantation]()

    for plantation in parentState.plantations {
        let isHarvestable = plantation.isHarvestable(onDay: day)
        let willRegrow = plantation.crop.regrowthDays != nil

        if isHarvestable {
            harvestedPlantations.append(plantation)
        }

        if !isHarvestable || willRegrow {
            remainingPlantations.append(plantation)
        }
    }

    let postHarvestGold = parentState.gold + harvestedPlantations.value
    let postHarvestAvailablePlots = maxPlots - remainingPlantations.amount

    var foundAnyPlantingOption = false
    generatePlantingOptions(day: day,
                            gold: postHarvestGold,
                            plots: postHarvestAvailablePlots) { plantingOption in
        foundAnyPlantingOption = true
        callback(SimulationState(parentState: parentState,
                                 day: day,
                                 plantations: remainingPlantations + plantingOption,
                                 gold: postHarvestGold - plantingOption.cost,
                                 harvestedPlantations: harvestedPlantations,
                                 plantedPlantations: plantingOption))
    }

    if !foundAnyPlantingOption {
        callback(SimulationState(parentState: parentState,
                                 day: day,
                                 plantations: remainingPlantations,
                                 gold: postHarvestGold,
                                 harvestedPlantations: harvestedPlantations))
    }
}
