struct AlgorithmFactory {
    private let algorithms: [String: Algorithm] = [
        "trapping-rainwater": TrappingRainwater(),
        "frequency-queries": FrequencyQueries(),
        "max-subarray-sum": MaxSubarraySum(),
        "pascal-triangle": PascalTriangle(),
        "missing-number": MissingNumber(),
        "count-triplets": CountTriplets(),
        "binary-search": BinarySearch(),
        "island-count": IslandCount()
    ]

    func make(name: String) throws -> Algorithm {
        guard let algorithm = algorithms[name] else {
            throw AlgorithmNotFound()
        }

        return algorithm
    }
}
