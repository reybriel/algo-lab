struct MissingNumber: Algorithm {

    // MARK: - Solution

    struct Solution {

        func run(array: [Int]) -> Int {
            var expectedSum = 0
            var obtainedSum = 0

            for i in (0 ..< array.count) {
                expectedSum += (i + 1)
                obtainedSum += array[i]
            }

            expectedSum += (array.count + 1)

            // another option is to use the formula
            // expectedSum = (array.count * (array.count + 1)) / 2

            return expectedSum - obtainedSum
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
        print("Missing number = \(result)")
    }
}
