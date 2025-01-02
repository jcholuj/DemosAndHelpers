// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DemosAndHelpers",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [],
    dependencies: []
)

// MARK: Demos
package.products.append(.library(name: "Demos", targets: ["Demos"]))
package.targets.append(.target(name: "Demos", dependencies: ["Helpers"]))

// MARK: Helpers
package.products.append(.library(name: "Helpers", targets: ["Helpers"]))
package.targets.append(.target(name: "Helpers"))
