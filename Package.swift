// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "dcb-library-ios",
    products: [
        .library(
            name: "dcb-library-ios",
            targets: ["dcb-library-ios"]
        ),
    ],
    targets: [
        .target(
            name: "dcb-library-ios",
            swiftSettings: [
                .define("SWIFT_VERSION_5")
            ]
        ),
        .testTarget(
            name: "dcb-library-iosTests",
            dependencies: ["dcb-library-ios"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
