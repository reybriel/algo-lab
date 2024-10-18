// HackerRank
struct FrequencyQueries: Algorithm {

    // MARK: - Solution

    struct Solution {

        func run(queries: [[Int]]) -> [Int] {
            var elFreq = [Int: Int]()
            var frFreq = [Int: Int]()
            var result = [Int]()

            for q in queries {
                let op = q[0]
                let el = q[1]

                switch op {
                case 1:
                    let freq = incrementOne(forKey: el, in: &elFreq)
                    incrementOne(forKey: freq, in: &frFreq)
                    decrementOne(forKey: freq - 1, in: &frFreq)
                case 2:
                    if let freq = elFreq[el] {
                        decrementOne(forKey: el, in: &elFreq)
                        decrementOne(forKey: freq, in: &frFreq)
                        if freq > 1 {
                            incrementOne(forKey: freq - 1, in: &frFreq)
                        }
                    }
                case 3:

                    if let fr = frFreq[el], fr > 0 {
                        result.append(1)
                    } else {
                        result.append(0)
                    }

                default:
                    fatalError("unexpected")
                }
            }

            return result
        }

        @discardableResult
        func incrementOne(forKey key: Int, in table: inout [Int: Int]) -> Int {
            var finalCount = 0

            if let count = table[key] {
                finalCount = count + 1
            } else {
                finalCount = 1
            }

            table[key] = finalCount
            return finalCount
        }

        @discardableResult
        func decrementOne(forKey key: Int, in table: inout [Int: Int]) -> Int {
            var finalCount = 0

            if let count = table.removeValue(forKey: key), count > 0 {
                finalCount = count - 1
                if finalCount > 0 {
                    table[key] = finalCount
                }
            }

            return finalCount
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let queries = try processInput(arguments: arguments)
        let result = Solution().run(queries: queries)
        printResult(result)
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> [[Int]] {
        guard arguments.count > 0 else {
            throw AlgorithmArgumentsError()
        }

        var input: [[Int]] = []
        for argument in arguments {
            let argParts = argument.split(separator: "-")

            guard argParts.count == 2 else {
                throw AlgorithmArgumentsError()
            }

            guard let op = Int(argParts[0]), let el = Int(argParts[1]) else {
                throw AlgorithmArgumentsError()
            }

            input.append([op, el])
        }

        return input
    }

    private func printResult(_ result: [Int]) {
        for r in result {
            print(r)
        }
    }
}
