// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let unicodeLinkerSettings: [LinkerSetting]
let unicodeTarget: [PackageDescription.Target]
let unicodeTargetDependency: [Target.Dependency]

if ProcessInfo.processInfo.environment["BUILD_ANDROID"] != nil {
    // We use Swift Toolchain's ICU for Android OS
    unicodeTarget = []
    unicodeTargetDependency = []
    unicodeLinkerSettings = [
        .linkedLibrary("icuucswift"),
        .linkedLibrary("icui18nswift"),
        .linkedLibrary("icudataswift")
    ]
} else {
    unicodeTarget = [
        .binaryTarget(
            name: "unicode",
            url: "https://github.com/readdle/icu4darwin/releases/download/68.2/icu68-2-darwin-no-strip-xcframework-dynamic.zip",
            checksum: "4e47b9ca38fd3d17d0bd4e6af2b5e906677a0abd94173b8208f0b64f07d21021"
        )
    ]
    unicodeTargetDependency = ["unicode"]
    unicodeLinkerSettings = []
}

let package = Package(
    name: "SQLite",
    products: [
        .library(name: "SQLite", targets: ["SQLite"]),
    ],
    targets: unicodeTarget + [
        .target(name: "SQLite",
                dependencies: unicodeTargetDependency,
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
                linkerSettings: unicodeLinkerSettings)
    ]
)
