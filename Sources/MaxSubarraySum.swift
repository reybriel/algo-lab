struct MaxSubarraySum: Algorithm {

    // MARK: - Solution

    struct Solution {

        // Kadane
        func run(array: [Int]) -> Int {
            var maxEnding = array[0]
            var maxSum = array[0]

            for i in (1 ..< array.count) {
                maxEnding = max(maxEnding + array[i], array[i])
                maxSum = max(maxSum, maxEnding)
            }

            return maxSum
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let array = try processInput(arguments: arguments)
        let result = Solution().run(array: array)
        printResult(result)
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> [Int] {
        guard arguments.count > 0 else {
            throw AlgorithmArgumentsError()
        }

        return try arguments.map { arg in
            if let num = Int(arg) {
                return num
            } else {
                throw AlgorithmArgumentsError()
            }
        }
    }

    private func printResult(_ result: Int) {
        print("Sum = \(result)")
    }
}
