// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AvoidCrash",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "AvoidCrash",
            targets: ["AvoidCrash"]
        )
    ],
    targets: [
        .target(
            name: "AvoidCrash",
            path: "AvoidCrash",
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ],
            publicHeadersPath: "."
        )
    ]
)
