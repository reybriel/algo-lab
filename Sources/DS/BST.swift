final class TreeNode<T: Comparable> {
    var key: T
    var height: Int = 1
    var lhs: TreeNode? = nil
    var rhs: TreeNode? = nil

    init(key: T) {
        self.key = key
    }
}

final class Tree<T: Comparable> {
    var root: TreeNode<T>?

    func insert(key: T) {
        root = Self.insert(key: key, from: root)
    }

    func remove(key: T) {
        root = Self.remove(key: key, from: root)
    }

    func traverse(_ kind: TraverseKind) {
        switch kind {
        case .bfs:
            Self.bfsTraversal(root)
        case .dfs(let order):
            switch order {
            case .inOrder:
                Self.inOrderTraversal(root)
            case .preOrder:
                Self.preOrderTraversal(root)
            case .postOrder:
                Self.postOrderTraversal(root)
            }
        }
    }

    enum TraverseKind {
        case dfs(DFSOrder)
        case bfs

        enum DFSOrder {
            case inOrder, preOrder, postOrder
        }
    }
}

extension Tree {
    static func getHeight(_ node: TreeNode<some Comparable>?) -> Int {
        guard let node else { return 0 }
        return node.height
    }

    static func getBalance(_ node: TreeNode<some Comparable>?) -> Int {
        guard let node else { return 0 }
        return getHeight(node.lhs) - getHeight(node.rhs)
    }

    static func rotateLeft<C: Comparable>(_ node: TreeNode<C>) -> TreeNode<C>? {
        let rhs = node.rhs
        let buf = rhs?.lhs

        rhs?.lhs = node
        node.rhs = buf

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        rhs?.height = max(getHeight(rhs?.lhs), getHeight(rhs?.rhs)) + 1

        return rhs
    }

    static func getMin<C: Comparable>(_ node: TreeNode<C>?) -> TreeNode<C>? {
        var current = node
        while current?.lhs != nil {
            current = current?.lhs
        }
        return current
    }

    static func rotateRight<C: Comparable>(_ node: TreeNode<C>) -> TreeNode<C>? {
        let lhs = node.lhs
        let buf = lhs?.rhs

        lhs?.rhs = node
        node.lhs = buf

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        lhs?.height = max(getHeight(lhs?.lhs), getHeight(lhs?.rhs)) + 1

        return lhs
    }

    static func adjustBalance<C: Comparable>(from node: TreeNode<C>?, key: C) -> TreeNode<C>? {
        guard let node else { return nil }

        let balance = getBalance(node)

        if balance > 1, let lhs = node.lhs, key < lhs.key {
            return rotateRight(node)
        }

        if balance < -1, let rhs = node.rhs, key > rhs.key {
            return rotateLeft(node)
        }

        if balance > 1, let lhs = node.lhs, key > lhs.key {
            node.lhs = rotateLeft(lhs)
            return rotateRight(node)
        }

        if balance < -1, let rhs = node.rhs, key < rhs.key {
            node.rhs = rotateRight(rhs)
            return rotateLeft(node)
        }

        return node
    }

    static func insert<C: Comparable>(key: C, from node: TreeNode<C>?) -> TreeNode<C>? {
        guard let node else { return TreeNode(key: key) }

        if key < node.key {
            node.lhs = insert(key: key, from: node.lhs)
        } else {
            node.rhs = insert(key: key, from: node.rhs)
        }

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        return adjustBalance(from: node, key: key)
    }

    static func remove<C: Comparable>(key: C, from node: TreeNode<C>?) -> TreeNode<C>? {
        guard let node else { return nil }

        if key < node.key {
            node.lhs = remove(key: key, from: node.lhs)
        } else if key > node.key {
            node.rhs = remove(key: key, from: node.rhs)
        } else {

            if node.lhs == nil {
                return node.rhs
            }

            if node.rhs == nil {
                return node.lhs
            }

            guard let temp = getMin(node.rhs) else {
                fatalError("should never be nil")
            }
            node.key = temp.key
            node.rhs = remove(key: temp.key, from: node.rhs)
        }

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        return adjustBalance(from: node, key: key)
    }

    static func preOrderTraversal(_ node: TreeNode<some Comparable>?) {
        guard let node else { return }

        print(node.key, terminator: " ")
        preOrderTraversal(node.lhs)
        preOrderTraversal(node.rhs)
    }

    static func inOrderTraversal(_ node: TreeNode<some Comparable>?) {
        guard let node else { return }

        inOrderTraversal(node.lhs)
        print(node.key, terminator: " ")
        inOrderTraversal(node.rhs)
    }

    static func postOrderTraversal(_ node: TreeNode<some Comparable>?) {
        guard let node else { return }

        postOrderTraversal(node.lhs)
        postOrderTraversal(node.rhs)
        print(node.key, terminator: " ")
    }

    static func bfsTraversal(_ node: TreeNode<some Comparable>?) {
        guard let node else { return }

        var queue: [TreeNode] = [node]

        while !queue.isEmpty {
            let node = queue.removeFirst()
            print(node.key, terminator: " ")

            if let lhs = node.lhs { queue.append(lhs) }
            if let rhs = node.rhs { queue.append(rhs) }
        }
    }
}
