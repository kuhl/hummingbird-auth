// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hummingbird-auth",
    platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17)],
    products: [
        .library(name: "HummingbirdAuth", targets: ["HummingbirdAuth"]),
        .library(name: "HummingbirdBasicAuth", targets: ["HummingbirdBasicAuth"]),
        .library(name: "HummingbirdBcrypt", targets: ["HummingbirdBcrypt"]),
        .library(name: "HummingbirdOTP", targets: ["HummingbirdOTP"]),
        .library(name: "HummingbirdAuthTesting", targets: ["HummingbirdAuthTesting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.5.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0"..<"5.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.63.0"),
        .package(url: "https://github.com/swift-extras/swift-extras-base64.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "HummingbirdAuth",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "ExtrasBase64", package: "swift-extras-base64"),
            ]
        ),
        .target(
            name: "HummingbirdBasicAuth",
            dependencies: [
                .byName(name: "HummingbirdAuth"),
                .byName(name: "HummingbirdBcrypt"),
                .product(name: "Hummingbird", package: "hummingbird"),
            ]
        ),
        .target(
            name: "HummingbirdBcrypt",
            dependencies: [
                .byName(name: "CBcrypt")
            ]
        ),
        .target(
            name: "HummingbirdOTP",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "ExtrasBase64", package: "swift-extras-base64"),
            ]
        ),
        .target(
            name: "HummingbirdAuthTesting",
            dependencies: [
                .byName(name: "HummingbirdAuth"),
                .product(name: "HummingbirdTesting", package: "hummingbird"),
            ]
        ),
        .target(name: "CBcrypt", dependencies: []),
        .testTarget(
            name: "HummingbirdAuthTests",
            dependencies: [
                .byName(name: "HummingbirdAuth"),
                .byName(name: "HummingbirdBasicAuth"),
                .byName(name: "HummingbirdBcrypt"),
                .byName(name: "HummingbirdOTP"),
                .byName(name: "HummingbirdAuthTesting"),
                .product(name: "HummingbirdTesting", package: "hummingbird"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ]
        ),
    ]
)
