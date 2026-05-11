// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KokoroSwift",
  platforms: [
    .iOS(.v18), .macOS(.v15)
  ],
  products: [
    .library(
      name: "KokoroSwift",
      type: .dynamic,
      targets: ["KokoroSwift"]
    ),
  ],
  dependencies: [
    // Pinned exact to match KokoroTestApp's Package.resolved (the canonical
    // reference app). The `from:` constraints in upstream 1.0.10 resolve to
    // newer MisakiSwift 1.0.6 + mlx-swift 0.30.2 which produced sharp
    // electronic noise during on-device audition (2026-05-11). KokoroTestApp
    // works with 0.29.1 / 1.0.5; we match exactly.
    .package(url: "https://github.com/ml-explore/mlx-swift", exact: "0.29.1"),
    // .package(url: "https://github.com/mlalma/eSpeakNGSwift", from: "1.0.1"),
    .package(url: "https://github.com/mlalma/MisakiSwift", exact: "1.0.5"),
    .package(url: "https://github.com/mlalma/MLXUtilsLibrary.git", exact: "0.0.6")
  ],
  targets: [
    .target(
      name: "KokoroSwift",
      dependencies: [
        .product(name: "MLX", package: "mlx-swift"),
        .product(name: "MLXNN", package: "mlx-swift"),
        .product(name: "MLXRandom", package: "mlx-swift"),
        .product(name: "MLXFFT", package: "mlx-swift"),
        // BuildingBlocks/LayerNormInference.swift imports MLXFast (uses
        // MLXFast.layerNorm). Without this declaration, Xcode device builds
        // fail at module resolution.
        .product(name: "MLXFast", package: "mlx-swift"),
        // .product(name: "eSpeakNGLib", package: "eSpeakNGSwift"),
        .product(name: "MisakiSwift", package: "MisakiSwift"),
        .product(name: "MLXUtilsLibrary", package: "MLXUtilsLibrary")
      ],
      resources: [
       .copy("../../Resources/")
      ]
    ),
    .testTarget(
      name: "KokoroSwiftTests",
      dependencies: ["KokoroSwift"]
    ),
  ]
)
