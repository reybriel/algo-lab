struct TrappingRainwater: Algorithm {

    // MARK: - Solution

    struct Solution {

        func run(array: [Int]) -> Int {
            var lhsIndex = 0
            var rhsIndex = array.count - 1

            var lhsHighest = 0
            var rhsHighest = 0

            var trapped = 0
            repeat {
                lhsHighest = max(lhsHighest, array[lhsIndex])
                rhsHighest = max(rhsHighest, array[rhsIndex])

                if lhsHighest <= rhsHighest {
                    trapped += lhsHighest - array[lhsIndex]
                    lhsIndex += 1
                } else {
                    trapped += rhsHighest - array[rhsIndex]
                    rhsIndex -= 1
                }

            } while lhsIndex != rhsIndex

            return trapped
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
            if let num = Int(arg), num >= 0 {
                return num
            } else {
                throw AlgorithmArgumentsError()
            }
        }
    }

    private func printResult(_ result: Int) {
        print("Units of water = \(result)")
    }
}
