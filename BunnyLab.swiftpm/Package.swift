// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "BunnyLab",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "BunnyLab",
            targets: ["AppModule"],
            bundleIdentifier: "com.BunnyLab",
            teamIdentifier: "X375XF3WN3",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                
                .phone
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [.process("Resources")]
        )
    ]
)
