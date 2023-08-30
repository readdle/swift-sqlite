// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

var dependencies: [PackageDescription.Package.Dependency] = []
var unicodeDependencies: [Target.Dependency] = []
var unicodeLinkerSettings: [LinkerSetting]?

if ProcessInfo.processInfo.environment["BUILD_ANDROID"] != nil {
    // We use Swift Toolchain's ICU for Android OS
    guard let icuVersion = ProcessInfo.processInfo.environment["SWIFT_ANDROID_ICU_VERSION"] else  {
        fatalError("Can't find SWIFT_ANDROID_ICU_VERSION env variable")
    }
    unicodeLinkerSettings = [
        .linkedLibrary("icuuc.\(icuVersion)"),
        .linkedLibrary("icui18n.\(icuVersion)"),
        .linkedLibrary("icudata.\(icuVersion)")
    ]
} else {
    dependencies = [
        .package(name: "unicode", url: "https://github.com/readdle/swift-unicode", .exact("68.2.0"))
    ]
    unicodeDependencies = ["unicode"]
}

let products: [PackageDescription.Product] = [
    .library(name: "SQLite", targets: ["SQLite"]),
]

let targets: [PackageDescription.Target] = [
    .target(
        name: "SQLite",
        dependencies: unicodeDependencies,
        cSettings: [
            .define("HAVE_USLEEP", to: "1"),
            .define("SQLITE_ENABLE_API_ARMOR", to: "1"),
            .define("SQLITE_ENABLE_ATOMIC_WRITE", to: "1"),
            .define("SQLITE_ENABLE_COLUMN_METADATA", to: "1"),
            .define("SQLITE_ENABLE_LOCKING_STYLE", to: "0"),
            .define("SQLITE_ENABLE_NORMALIZE", to: "1"),
            .define("SQLITE_ENABLE_FTS5", to: "1"),
            .define("SQLITE_ENABLE_ICU", to: "1"),
            .define("SQLITE_ENABLE_RTREE", to: "1"),
            .define("SQLITE_ENABLE_UNLOCK_NOTIFY", to: "1"),
        ],
        linkerSettings: unicodeLinkerSettings
    )
]

let package = Package(
    name: "SQLite",
    products: products,
    dependencies: dependencies,
    targets: targets
)
