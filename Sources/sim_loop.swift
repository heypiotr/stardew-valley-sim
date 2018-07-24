import Foundation

private class SimulationOperation: Operation {
    enum ProcessingType {
        case depthFirst
        case breadthFirstStoppingAfter(Int)
    }

    init(startingStates: [SimulationState], processingType: ProcessingType) {
        self.states = startingStates

        super.init()

        switch processingType {
        case .depthFirst:
            nextState = { [unowned self] in self.states.popLast() }
        case .breadthFirstStoppingAfter(let stopCount):
            nextState = { [unowned self] in
                self.states.count >= stopCount || self.states.isEmpty ? nil : self.states.removeFirst()
            }
        }
    }

    private var nextState: (() -> SimulationState?)!

    private(set) var states: [SimulationState]
    private(set) var statesProcessedCount = 0

    private(set) var results = SimulationResults()

    override func main() {
        while let parentState = nextState() {
            statesProcessedCount += 1
            generateSimulationBranches(parentState: parentState) { state in
                if state.nextDay == nil { results.insert(state) }
                else { states.append(state) }
            }
        }
    }
}

func performSimulation(operationsCount: Int) -> SimulationResults {
    let startingOperation = SimulationOperation(startingStates: [STARTING_STATE],
                                                processingType: .breadthFirstStoppingAfter(operationsCount))
    startingOperation.main()

    var startingStatesPerOperation = [[SimulationState]](repeating: [], count: operationsCount)
    for (index, state) in startingOperation.states.enumerated() {
        startingStatesPerOperation[index % operationsCount].append(state)
    }
    let operations = startingStatesPerOperation.map { SimulationOperation(startingStates: $0,
                                                                          processingType: .depthFirst) }

    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = ProcessInfo.processInfo.activeProcessorCount
    queue.addOperations(operations, waitUntilFinished: true)

    let totalStatesProcessedCount = startingOperation.statesProcessedCount
        + operations.reduce(0) { $0 + $1.statesProcessedCount }
    print("totalStatesProcessedCount = \(formatNumber(totalStatesProcessedCount))")

    var allResults = operations.map { $0.results }
    allResults.append(startingOperation.results)

    let finalResults = SimulationResults(allResults)
    return finalResults
}
