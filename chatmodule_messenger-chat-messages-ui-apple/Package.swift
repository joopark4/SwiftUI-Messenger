// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ChatModuleMessengerChatMessagesUI",
    defaultLocalization: "ko",
    platforms: [.iOS(.v14), .macOS("11")],
    products: [
        .library(
            name: "ChatModuleMessengerChatMessagesUI",
            targets: ["ChatModuleMessengerChatMessagesUI"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageWebPCoder.git", from: "0.8.4"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
        .package(name: "ChatModuleMessengerUI",
                 path: "../chatmodule_messenger-ui-apple"),
        .package(name: "ChatModuleMessengerChatRoomUI",
                 path: "../chatmodule_messenger-chat-room-ui-apple")
    ],
    targets: [
        .target(
            name: "ChatModuleMessengerChatMessagesUI",
            dependencies: ["ChatModuleMessengerUI", "ChatModuleMessengerChatRoomUI", "SDWebImageSwiftUI", "SDWebImageWebPCoder"]),

        .testTarget(
            name: "ChatModuleMessengerChatMessagesUITests",
            dependencies: ["ChatModuleMessengerChatMessagesUI"])
    ]
)
