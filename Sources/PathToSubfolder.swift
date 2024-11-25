// run command => path-to-subfolder 9 0-7,3-abc 0-*-def 3-*-ghi 7-9-jkl 9-*-mno 8-*-pqr
// result => abc -> jkl -> mno

struct PathToSubfolder: Algorithm {

    // MARK: - Solution

    struct Folder {
        let id: Int
        let subfolders: [Int]
        let name: String
    }

    final class Solution {
        let target: Int
        let rootFolders: [Folder]
        var foldersById: [Int: Folder] = [:]

        init(target: Int, folders: [Folder]) {
            self.target = target

            var rootFolders: [Folder] = []
            var foldersById: [Int: Folder] = [:]

            for folder in folders {
                if folder.id == 0 {
                    rootFolders.append(folder)
                } else {
                    foldersById[folder.id] = folder
                }
            }

            self.rootFolders = rootFolders
            self.foldersById = foldersById
        }

        func run() throws -> String {
            var path: [String] = []

            for rootFolder in rootFolders {
                if try searchFolderDFS(folder: rootFolder, path: &path) {
                    break
                }
            }

            return path.reversed().joined(separator: " -> ")
        }

        @discardableResult
        private func searchFolderDFS(folder: Folder, path: inout [String]) throws -> Bool {
            guard folder.id != target else {
                path.append(folder.name)
                return true
            }

            for subfolder in folder.subfolders {
                let instance = try searchFolderInstance(id: subfolder)

                if try searchFolderDFS(folder: instance, path: &path) {
                    path.append(folder.name)
                    return true
                }
            }

            return false
        }

        private func searchFolderInstance(id: Int) throws -> Folder {
            guard let found = foldersById[id] else {
                throw AlgorithmArgumentsError()
            }

            return found
        }
    }

    // MARK: - Algorithm conformance

    func run(arguments: [String]) throws {
        let (target, folders) = try processInput(arguments: arguments)
        let path = try Solution(target: target, folders: folders).run()
        print(path)
    }

}

    // MARK: - Helpers

extension PathToSubfolder {

    func processInput(arguments: [String]) throws -> (Int, [Folder]) {
        guard
            arguments.count >= 2,
            let target = Int(arguments[0])
        else { throw AlgorithmArgumentsError() }

        let folders = try arguments[1...].map { argument in
            let folderParts = argument.split(separator: "-")

            guard folderParts.count == 3 else {
                throw AlgorithmArgumentsError()
            }

            guard let folderId = Int(folderParts[0]) else {
                throw AlgorithmNotFound()
            }

            let subfolders = if folderParts[1] != "*" {
                folderParts[1]
                    .split(separator: ",")
                    .compactMap { subfolderId in
                        Int(subfolderId)
                    }
            } else {
                [Int]()
            }

            let folderName = String(folderParts[2])

            return Folder(id: folderId, subfolders: subfolders, name: folderName)
        }

        return (target, folders)
    }
}
