// HackerRank
struct CountTriplets: Algorithm {

    // MARK: - Solution

    struct Solution {
        func run(arr: [Int], r: Int) -> Int {
            var secondNumTable = [Int: Int]()
                var thirdNumTable = [Int: Int]()
                var tripletsCount = 0

                for i in 0 ..< arr.count {
                    if let thirdCount = thirdNumTable[arr[i]] {
                        tripletsCount += thirdCount
                    }

                    if let secondCount = secondNumTable[arr[i]] {
                        increment(secondCount, forKey: arr[i] * r, in: &thirdNumTable)
                    }

                    increment(1, forKey: arr[i] * r, in: &secondNumTable)
                }

                return tripletsCount
        }

        private func increment(_ value: Int, forKey key: Int, in table: inout [Int: Int]) {
            if let count = table[key] {
                table[key] = count + value
            } else {
                table[key] = value
            }
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let input = try processInput(arguments: arguments)
        let result = Solution().run(arr: input.arr, r: input.r)
        printResult(result)
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> (arr: [Int], r: Int) {
        guard arguments.count >= 4 else {
            throw AlgorithmArgumentsError()
        }

        var values = [Int]()
        for argument in arguments {
            guard let num = Int(argument) else {
                throw AlgorithmArgumentsError()
            }

            values.append(num)
        }

        return (Array(values[1...]), values[0])
    }

    private func printResult(_ result: Int) {
        print("Triplets Count = \(result)")
    }

}
