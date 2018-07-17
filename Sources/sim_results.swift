import BTree

struct SimulationResults: Collection {
    let limit = RESULTS_LIMIT

    init() {
    }

    init(_ arrayOfResults: [SimulationResults]) {
        for results in arrayOfResults {
            for result in results {
                insert(result)
            }
        }
    }

    mutating func insert(_ newElement: Element) {
        if backingCollection.count < limit {
            backingCollection.insert(newElement)
        } else {
            let bottomElement = backingCollection.first!
            if (bottomElement == newElement) {
                backingCollection.insert(newElement)
            } else if (bottomElement < newElement) {
                backingCollection.insert(newElement)
                backingCollection.removeAll(bottomElement)
            }
        }
    }

    // MARK: - Backing array & Collection conformance

    typealias BackingType = SortedBag<SimulationState>

    private var backingCollection = BackingType()

    typealias Index = BackingType.Index
    typealias Element = BackingType.Element

    var startIndex: Index { return backingCollection.startIndex }
    var endIndex: Index { return backingCollection.endIndex }

    subscript(index: Index) -> Element {
        get { return backingCollection[index] }
    }

    func index(after i: Index) -> Index {
        return backingCollection.index(after: i)
    }
}

extension SimulationState: Comparable {
    static func < (lhs: SimulationState, rhs: SimulationState) -> Bool {
        return lhs.gold < rhs.gold
    }

    static func == (lhs: SimulationState, rhs: SimulationState) -> Bool {
        return lhs.gold == rhs.gold
    }
}
