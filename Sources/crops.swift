struct Crop {
    let name: String
    let seedPrice: UInt
    let sellPrice: UInt
    let yield: Double
    let growthDays: UInt
    let regrowthDays: UInt?
}

let blueJazz    = Crop(name: "blueJazz",    seedPrice: 30,      sellPrice: 50,  yield: 1,   growthDays: 7,  regrowthDays: nil)
let cauliflower = Crop(name: "cauliflower", seedPrice: 80,      sellPrice: 175, yield: 1,   growthDays: 12, regrowthDays: nil)
let coffeeBean  = Crop(name: "coffeeBean",  seedPrice: 2500,    sellPrice: 15,  yield: 4,   growthDays: 10, regrowthDays: 2  )
let garlic      = Crop(name: "garlic",      seedPrice: 40,      sellPrice: 60,  yield: 1,   growthDays: 4,  regrowthDays: nil)
let greenBean   = Crop(name: "greenBean",   seedPrice: 60,      sellPrice: 40,  yield: 1,   growthDays: 10, regrowthDays: 3  )
let kale        = Crop(name: "kale",        seedPrice: 70,      sellPrice: 110, yield: 1,   growthDays: 6,  regrowthDays: nil)
let parsnip     = Crop(name: "parsnip",     seedPrice: 20,      sellPrice: 35,  yield: 1,   growthDays: 4,  regrowthDays: nil)
let potato      = Crop(name: "potato",      seedPrice: 50,      sellPrice: 80,  yield: 1.2, growthDays: 6,  regrowthDays: nil)
let rhubarb     = Crop(name: "rhubarb",     seedPrice: 100,     sellPrice: 220, yield: 1,   growthDays: 13, regrowthDays: nil)
let strawberry  = Crop(name: "strawberry",  seedPrice: 100,     sellPrice: 120, yield: 1,   growthDays: 8,  regrowthDays: 4  )
let tulip       = Crop(name: "tulip",       seedPrice: 20,      sellPrice: 30,  yield: 1,   growthDays: 6,  regrowthDays: nil)

let springCrops = [
    blueJazz,
    cauliflower,
//    coffeeBean, // loot or travelling cart
//    garlic, // year 2+
    greenBean,
    kale,
    parsnip,
    potato,
//    rhubarb, // desert
//    strawberry, // egg festival
    tulip,
]

let blueberry   = Crop(name: "blueberry",   seedPrice: 80,      sellPrice: 50,  yield: 3,   growthDays: 13, regrowthDays: 4  )
let corn        = Crop(name: "corn",        seedPrice: 150,     sellPrice: 50,  yield: 1,   growthDays: 14, regrowthDays: 4  )
let hops        = Crop(name: "hops",        seedPrice: 60,      sellPrice: 25,  yield: 1,   growthDays: 11, regrowthDays: 1  )
let hotPepper   = Crop(name: "hotPepper",   seedPrice: 40,      sellPrice: 40,  yield: 1,   growthDays: 5,  regrowthDays: 3  )
let melon       = Crop(name: "melon",       seedPrice: 80,      sellPrice: 250, yield: 1,   growthDays: 12, regrowthDays: nil)
let poppy       = Crop(name: "poppy",       seedPrice: 100,     sellPrice: 140, yield: 1,   growthDays: 7,  regrowthDays: nil)
let radish      = Crop(name: "radish",      seedPrice: 40,      sellPrice: 90,  yield: 1,   growthDays: 6,  regrowthDays: nil)
let redCabbage  = Crop(name: "redCabbage",  seedPrice: 100,     sellPrice: 260, yield: 1,   growthDays: 9,  regrowthDays: nil)
let starfruit   = Crop(name: "starfruit",   seedPrice: 400,     sellPrice: 750, yield: 1,   growthDays: 13, regrowthDays: nil)
let spangle     = Crop(name: "spangle",     seedPrice: 50,      sellPrice: 90,  yield: 1,   growthDays: 8,  regrowthDays: nil)
let sunflower   = Crop(name: "sunflower",   seedPrice: 200,     sellPrice: 80,  yield: 1,   growthDays: 8,  regrowthDays: nil)
let tomato      = Crop(name: "tomato",      seedPrice: 50,      sellPrice: 60,  yield: 1,   growthDays: 11, regrowthDays: 4  )
let wheat       = Crop(name: "wheat",       seedPrice: 10,      sellPrice: 25,  yield: 1,   growthDays: 4,  regrowthDays: nil)

let summerCrops = [
    blueberry,
    corn,
    hops,
    hotPepper,
    melon,
    poppy,
    radish,
//    redCabbage, // year 2+
//    starfruit, // desert
    spangle,
//    sunflower, // negative
    tomato,
    wheat
]
