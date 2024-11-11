struct BinarySearch: Algorithm {

    // MARK: - Solution

    struct Solution {
        func run(q: Int, arr: [Int]) -> Int {
            var start = 0, end = arr.count - 1

            while start <= end {
                let pivot = (start + end) / 2
                let diff = q - arr[pivot]

                if diff == 0 {
                    return pivot
                }

                if diff > 0 {
                    start = pivot + 1
                } else {
                    end = pivot - 1
                }
            }

            return -1
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let input = try processInput(arguments: arguments)
        let result = Solution().run(q: input.q, arr: input.arr)

        if result == -1 {
            print("\(input.q) not found in \(input.arr)")
        } else {
            print("\(input.q) found in index \(result) of \(input.arr)")
        }
    }

    // MARK: - Helpers

    private func processInput(arguments: [String]) throws -> (q: Int, arr: [Int]) {
        guard arguments.count >= 2, let q = Int(arguments[0]) else {
            throw AlgorithmArgumentsError()
        }

        let arr = arguments[1...].compactMap(Int.init)
        for i in 0 ... arr.count - 2 {
            guard arr[i] < arr[i + 1] else {
                throw AlgorithmArgumentsError() // array not sorted
            }
        }

        return (q, arguments[1...].compactMap(Int.init))
    }

}
