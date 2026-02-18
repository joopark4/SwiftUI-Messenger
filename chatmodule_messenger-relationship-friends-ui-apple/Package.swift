// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ChatModuleMessengerRelationshipFriendsUI",
    defaultLocalization: "ko",
    platforms: [.iOS(.v14), .macOS("11")],
    products: [
        .library(
            name: "ChatModuleMessengerRelationshipFriendsUI",
            targets: ["ChatModuleMessengerRelationshipFriendsUI"])
    ],
    dependencies: [
        // local package
        .package(name: "ChatModuleMessengerUI",
                 path: "../chatmodule_messenger-ui-apple")
    ],
    targets: [
        .target(
            name: "ChatModuleMessengerRelationshipFriendsUI",
            dependencies: ["ChatModuleMessengerUI"]),

        .testTarget(
            name: "ChatModuleMessengerRelationshipFriendsUITests",
            dependencies: ["ChatModuleMessengerRelationshipFriendsUI"])
    ]
)
