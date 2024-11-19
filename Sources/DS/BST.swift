final class TreeNode {
    let key: Int
    var height: Int = 1
    var lhs: TreeNode? = nil
    var rhs: TreeNode? = nil

    init(key: Int) {
        self.key = key
    }
}

final class Tree {
    var root: TreeNode?

    func insert(key: Int) {
        root = Self.insert(key: key, from: root)
    }
}

extension Tree {
    static func getHeight(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }
        return node.height
    }

    static func getBalance(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }
        return getHeight(node.lhs) - getHeight(node.rhs)
    }

    static func rotateLeft(_ node: TreeNode) -> TreeNode? {
        let rhs = node.rhs
        let buf = rhs?.lhs

        rhs?.lhs = node
        node.rhs = buf

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        rhs?.height = max(getHeight(rhs?.lhs), getHeight(rhs?.rhs)) + 1

        return rhs
    }

    static func rotateRight(_ node: TreeNode) -> TreeNode? {
        let lhs = node.lhs
        let buf = lhs?.rhs

        lhs?.rhs = node
        node.lhs = buf

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
        lhs?.height = max(getHeight(lhs?.lhs), getHeight(lhs?.rhs)) + 1

        return lhs
    }

    static func insert(key: Int, from node: TreeNode?) -> TreeNode? {
        guard let node else { return TreeNode(key: key) }

        if key < node.key {
            node.lhs = insert(key: key, from: node.lhs)
        } else {
            node.rhs = insert(key: key, from: node.rhs)
        }

        node.height = max(getHeight(node.lhs), getHeight(node.rhs)) + 1
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
}