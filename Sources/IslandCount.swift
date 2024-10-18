struct IslandCount: Algorithm {

    // MARK: - Solution

    struct Solution {
        func run(input: inout [[Int]]) -> Int {
            var islandCount = 0

            for i in 0 ..< input.count {
                for j in 0 ..< input[i].count {
                    guard input[i][j] == 1 else { continue }
                    islandCount += 1
                    eraseAdjacent(from: &input, coordinates: (i, j))
                }
            }

            return islandCount
        }

        private func eraseAdjacent(from input: inout [[Int]], coordinates: (x: Int, y: Int)) {
            guard
                coordinates.y >= 0,
                coordinates.x >= 0,
                coordinates.y < input.count,
                coordinates.x < input[coordinates.y].count,
                input[coordinates.x][coordinates.y] != 0
            else { return }

            input[coordinates.x][coordinates.y] = 0

            eraseAdjacent(from: &input, coordinates: (coordinates.x - 1, coordinates.y))
            eraseAdjacent(from: &input, coordinates: (coordinates.x + 1, coordinates.y))
            eraseAdjacent(from: &input, coordinates: (coordinates.x, coordinates.y - 1))
            eraseAdjacent(from: &input, coordinates: (coordinates.x, coordinates.y + 1))
        }
    }

    // MARK: - Algorithm Conformance

    func run(arguments: [String]) throws {
        var input = try processInput(arguments: arguments)
        let islandCount = Solution().run(input: &input)
        printResult(islandCount)
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> [[Int]] {
        guard arguments.count > 0 else {
            throw AlgorithmArgumentsError()
        }

        let firstCount = arguments[0].count
        guard arguments.allSatisfy({ $0.count == firstCount }) else {
            throw AlgorithmArgumentsError()
        }

        var input = [[Int]]()

        for arg in arguments {
            var line = [Int]()

            for c in arg {
                guard let num = Int(String(c)), num == 0 || num == 1 else {
                    throw AlgorithmArgumentsError()
                }

                line.append(num)
            }

            input.append(line)
        }

        return input
    }

    private func printResult(_ result: Int) {
        print("Island Count = \(result)")
    }
}
