struct PascalTriangle: Algorithm {

    // MARK: - Solution

    struct Solution {
        func run(numberOfRows: Int) -> [[Int]] {
            var triangle = [[1]]
            if numberOfRows == 1 { return triangle }

            triangle.append([1, 1])
            if numberOfRows == 2 { return triangle }

            for i in (2 ..< numberOfRows) {
                var level = [1]
                let prev = triangle[i - 1]

                for j in (1 ..< i) {
                    level.append(prev[j - 1] + prev[j])
                }

                level.append(1)
                triangle.append(level)
            }

            return triangle
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let numberOfRows = try processInput(arguments: arguments)
        let result = Solution().run(numberOfRows: numberOfRows)
        printResult(result)
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> Int {
        guard
            arguments.count == 1,
            let numRows = Int(arguments[0]),
            numRows > 0
        else {
            throw AlgorithmArgumentsError()
        }

        return numRows
    }

    private func printResult(_ result: [[Int]]) {
        for i in 0 ..< result.count {

            for num in result[i] {
                print(num, " ", terminator: "")
            }

            print()
        }
    }
}
