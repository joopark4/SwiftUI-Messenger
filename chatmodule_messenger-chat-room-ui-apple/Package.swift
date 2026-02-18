// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ChatModuleMessengerChatRoomUI",
    defaultLocalization: "ko",
    platforms: [.iOS(.v14), .macOS("11")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ChatModuleMessengerChatRoomUI",
            targets: ["ChatModuleMessengerChatRoomUI"])
    ],
    dependencies: [
        // local package
        .package(name: "ChatModuleMessengerUI",
                 path: "../chatmodule_messenger-ui-apple")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ChatModuleMessengerChatRoomUI",
            dependencies: ["ChatModuleMessengerUI"]),
        .testTarget(
            name: "ChatModuleMessengerChatRoomUITests",
            dependencies: ["ChatModuleMessengerChatRoomUI"])
    ]
)
