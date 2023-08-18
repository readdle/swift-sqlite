// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

var dependencies: [PackageDescription.Package.Dependency] = []
var unicodeDependencies: [Target.Dependency] = []
var unicodeLinkerSettings: [LinkerSetting]?

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
