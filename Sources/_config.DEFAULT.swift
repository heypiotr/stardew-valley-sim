let OPERATIONS_COUNT = 100

let FARMING_LEVEL = 0

let ENERGY_ALLOWANCE = 250.0
let MAX_PLOTS = UInt(ENERGY_ALLOWANCE / WateringCan.starter.energyPerTile(farmingLevel: FARMING_LEVEL))

let CROPS = springCrops

let STARTING_DAY: UInt = 1
let STARTING_GOLD: UInt = 500
let STARTING_PLANTATIONS: [Plantation] = [
    Plantation(crop: parsnip, amount: 15, dayPlanted: 1),
]

let STARTING_STATE = SimulationState(parentState: nil,
                                     day: STARTING_DAY,
                                     plantations: STARTING_PLANTATIONS,
                                     gold: STARTING_GOLD,
                                     plantedPlantations: STARTING_PLANTATIONS,
                                     nextDay: STARTING_DAY)

let RESULTS_LIMIT = 1000
