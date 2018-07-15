struct SimulationResults: Collection {
    let limit = RESULTS_LIMIT

    typealias Comparator = (Element, Element) -> Bool

    let areEqual: Comparator = { $0.gold == $1.gold }
    let areInIncreasingOrder: Comparator = { $0.gold < $1.gold }

    init() {
    }

    init(_ arrayOfResults: [SimulationResults]) {
        for results in arrayOfResults {
            array.append(contentsOf: results)
        }
        array.sort(by: areInIncreasingOrder)

        if array.count >= limit {
            let rarray: ArrayType = array.reversed()

            let bottomElement = rarray[limit - 1]
            let firstNotTiedAfterBottom = rarray[limit...].index(where: { !areEqual(bottomElement, $0) }) ?? rarray.endIndex

            let removeCount = rarray.endIndex - firstNotTiedAfterBottom
            array.removeFirst(removeCount)
        }
    }

    mutating func insert(_ newElement: Element) {
        if array.count < limit {
            array.append(newElement)
            array.sort(by: areInIncreasingOrder)
        } else {
            let bottomElement = array[0]
            if (areEqual(bottomElement, newElement)) {
                array.insert(newElement, at: 0)
            } else if (areInIncreasingOrder(bottomElement, newElement)) {
                array.append(newElement)
                array.sort(by: areInIncreasingOrder)

                let bottomTiesCount = array
                    .index(where: { areInIncreasingOrder(bottomElement, $0) }) ?? array.endIndex

                if (array.count - bottomTiesCount >= limit) {
                    array.removeFirst(bottomTiesCount)
                }
            }
        }
    }

    // MARK: - Backing array & Collection conformance

    typealias ArrayType = [SimulationState]

    private var array = ArrayType()

    typealias Index = ArrayType.Index
    typealias Element = ArrayType.Element

    var startIndex: Index { return array.startIndex }
    var endIndex: Index { return array.endIndex }

    subscript(index: Index) -> ArrayType.Element {
        get { return array[index] }
    }

    func index(after i: ArrayType.Index) -> ArrayType.Index {
        return array.index(after: i)
    }
}
