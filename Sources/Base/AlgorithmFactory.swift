struct AlgorithmFactory {
    private let algorithms: [String: Algorithm] = [
        "frequency-queries": FrequencyQueries(),
        "pascal-triangle": PascalTriangle(),
        "count-triplets": CountTriplets(),
        "island-count": IslandCount()
    ]

    func make(name: String) throws -> Algorithm {
        guard let algorithm = algorithms[name] else {
            throw AlgorithmNotFound()
        }

        return algorithm
    }
}
