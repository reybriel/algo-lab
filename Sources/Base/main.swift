do {
    let arguments = CommandLine.arguments

    let algorithmName = arguments[1]
    let algorithmArguments = Array(arguments[2...])

    let algorithmFactory = AlgorithmFactory()
    let algorithm = try algorithmFactory.make(name: algorithmName)
    try algorithm.run(arguments: algorithmArguments)

} catch {

    if error is AlgorithmNotFound {
        print("Error: algorithm not found in this project!")
    }

    else if error is AlgorithmArgumentsError {
        print("Error: there is something wrong with the input arguments!")
    }

    else {
        print("Error: unknown.")
    }

    exit(1)
}
