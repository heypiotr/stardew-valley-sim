struct Plantation: CustomStringConvertible {
    let crop: Crop
    let amount: UInt
    let dayPlanted: UInt

    init(crop: Crop, amount: UInt, dayPlanted: UInt) {
        assert(dayPlanted + crop.growthDays <= 28)

        self.crop = crop
        self.amount = amount
        self.dayPlanted = dayPlanted
    }

    var cost: UInt {
        return crop.seedPrice * amount
    }

    var value: UInt {
        return UInt(Double(amount * crop.sellPrice) * crop.yield)
    }

    var wateringCost: UInt {
        var wateringDays = crop.growthDays

        if let regrowthDays = crop.regrowthDays {
            let regrowthCount = (28 - dayPlanted - crop.growthDays) / regrowthDays
            let totalRegrowthDays = regrowthDays * regrowthCount

            wateringDays += totalRegrowthDays
        }

        return wateringDays * amount
    }

    var description: String {
        return String(format: "D%02d \(crop.name) x \(amount)", dayPlanted)
    }

    func isHarvestable(onDay day: UInt) -> Bool {
        if day < dayPlanted + crop.growthDays {
            return false
        }

        if crop.regrowthDays == nil {
            return day - dayPlanted - crop.growthDays == 0
        } else {
            return (day - dayPlanted - crop.growthDays) % crop.regrowthDays! == 0
        }
    }

    func nextHarvestDay(afterDay day: UInt) -> UInt? {
        let grownDay = dayPlanted + crop.growthDays
        if grownDay > day {
            return grownDay > 28 ? nil : grownDay
        } else if let regrowthDays = crop.regrowthDays {
            let regrowthCount = (day - dayPlanted - crop.growthDays) / regrowthDays + 1
            let regrownDay = grownDay + regrowthDays * regrowthCount
            return regrownDay > 28 ? nil : regrownDay
        } else {
            return nil
        }
    }
}

extension Array where Element == Plantation {
    var amount: UInt {
        return reduce(0) { $0 + $1.amount }
    }

    var cost: UInt {
        return reduce(0) { $0 + $1.cost }
    }

    var value: UInt {
        return reduce(0) { $0 + $1.value }
    }

    var wateringCost: UInt {
        return reduce(0) { $0 + $1.wateringCost }
    }

    func nextHarvestDay(afterDay day: UInt) -> UInt? {
        return compactMap { $0.nextHarvestDay(afterDay: day) }.min()
    }
}

func generatePlantingOptions(day: UInt, gold: UInt, plots: UInt, callback: ([Plantation]) -> Void) {
    for primaryCrop in CROPS {
        if day + primaryCrop.growthDays > 28 { continue }

        let primarySeedsCount = min(gold / primaryCrop.seedPrice, plots)
        if primarySeedsCount == 0 { continue }

        callback([Plantation(crop: primaryCrop, amount: primarySeedsCount, dayPlanted: day)])

        // sometimes, sticking to max-size primary-crop plantation is better than trying to find a secondary crop
        // TBD: maybe only look for secondary crops with better profitability-per-day?

        if primarySeedsCount == plots {
            let leftoverGold = gold - primarySeedsCount * primaryCrop.seedPrice

            for secondaryCrop in CROPS {
                if day + secondaryCrop.growthDays > 28 { continue }
                if secondaryCrop.seedPrice <= primaryCrop.seedPrice { continue }

                let secondarySeedsCount = min(leftoverGold / (secondaryCrop.seedPrice - primaryCrop.seedPrice), plots)
                if secondarySeedsCount == 0 { continue }
                if secondarySeedsCount == primarySeedsCount { continue }

                callback([Plantation(crop: primaryCrop, amount: primarySeedsCount - secondarySeedsCount, dayPlanted: day),
                          Plantation(crop: secondaryCrop, amount: secondarySeedsCount, dayPlanted: day)])
            }
        }
    }
}
