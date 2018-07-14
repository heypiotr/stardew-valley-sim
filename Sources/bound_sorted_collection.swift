struct BoundSortedCollection<E>: Collection {

    let limit: Int

    typealias Comparator = (Element, Element) -> Bool

    let areEqual: Comparator
    let areInIncreasingOrder: Comparator

    init(limit: Int, areEqual: @escaping Comparator, areInIncreasingOrder: @escaping Comparator) {
        self.limit = limit

        self.areEqual = areEqual
        self.areInIncreasingOrder = areInIncreasingOrder
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

    typealias ArrayType = [E]

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
