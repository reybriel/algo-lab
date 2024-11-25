// run-command => traverse-tree 1 2 3 4 5 6 7 8 9 10
// output:
// BFS: 4 2 8 1 3 6 9 5 7 10
// DFS(in-order): 1 2 3 4 5 6 7 8 9 10
// DFS(pre-order): 4 2 1 3 8 6 5 7 9 10
// DFS(post-order): 1 3 2 5 7 6 10 9 8 4

struct TraverseTree: Algorithm {

    // MARK: - Solution

    struct Solution {

        func run(array: [Int]) {
            let tree = Tree<Int>()

            for item in array {
                tree.insert(key: item)
            }

            print("BFS:", terminator: " ")
            tree.traverse(.bfs)
            print()

            print("DFS(in-order):", terminator: " ")
            tree.traverse(.dfs(.inOrder))
            print()

            print("DFS(pre-order):", terminator: " ")
            tree.traverse(.dfs(.preOrder))
            print()

            print("DFS(post-order):", terminator: " ")
            tree.traverse(.dfs(.postOrder))
            print()
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let array = try processInput(arguments: arguments)
        Solution().run(array: array)
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
