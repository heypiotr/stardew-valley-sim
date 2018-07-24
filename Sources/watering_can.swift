enum WateringCan {
    case starter
    case copper
    case steel
    case gold
    case iridium

    var tiles: Int {
        switch self {
        case .starter:  return 1
        case .copper:   return 3
        case .steel:    return 5
        case .gold:     return 9
        case .iridium:  return 18
        }
    }

    var energyCost: Int {
        switch self {
        case .starter:  return 2
        case .copper:   return 4
        case .steel:    return 6
        case .gold:     return 8
        case .iridium:  return 10
        }
    }

    func energyPerTile(farmingLevel: Int) -> Double {
        return (Double(energyCost) - Double(farmingLevel) * 0.1) / Double(tiles)
    }
}
