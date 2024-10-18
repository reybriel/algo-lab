import ProjectDescription

let project = Project(
    name: "algo-lab",
    options:  .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    targets: [
        .target(
            name: "algo-lab",
            destinations: .macOS,
            product: .commandLineTool,
            bundleId: "com.rebriel.algo-lab",
            deploymentTargets: .macOS("14.1"),
            sources: "Sources/**"
        )
    ],
    schemes: [
        .scheme(
            name: "algo-lab",
            buildAction: .buildAction(targets: ["algo-lab"]),
            runAction: .runAction(executable: "algo-lab")
        )
    ]
)
