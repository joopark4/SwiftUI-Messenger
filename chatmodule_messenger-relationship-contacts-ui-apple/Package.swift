// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ChatModuleMessengerRelationshipContactsUI",
    platforms: [.iOS(.v14), .macOS("11")],
    products: [
        .library(
            name: "ChatModuleMessengerRelationshipContactsUI",
            targets: ["ChatModuleMessengerRelationshipContactsUI"]),
    ],
    dependencies: [
        // local package
        .package(name: "ChatModuleMessengerUI",
                 path: "../chatmodule_messenger-ui-apple")
    ],
    targets: [
        .target(
            name: "ChatModuleMessengerRelationshipContactsUI",
            dependencies: ["ChatModuleMessengerUI"]),
        
        .testTarget(
            name: "ChatModuleMessengerRelationshipContactsUITests",
            dependencies: ["ChatModuleMessengerRelationshipContactsUI"]),
    ]
)
