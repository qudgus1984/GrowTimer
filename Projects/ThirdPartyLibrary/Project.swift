//
//  Project.swift
//  AppManifests
//
//  Created by Den on 4/28/25.
//

import ProjectDescription

let project = Project(
    name: "ThirdPartyLibrary",
    organizationName: "Den",
    packages: [
        .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMajor(from: "3.2.0")),
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.9.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1"))

    ],
    targets: [
        Target.target(
            name: "ThirdPartyLibrary",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.thirdpartylibrary",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .package(product: "ReactorKit", type: .runtime),
                .package(product: "RxCocoa", type: .runtime),
                .package(product: "RxSwift", type: .runtime),
                .package(product: "SnapKit", type: .runtime),
                .project(target: "GTToast", path: "../GTToast"),
            ]
        ),
        Target.target(
            name: "ThirdPartyLibraryTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.thirdpartylibrary.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "ThirdPartyLibrary")
            ]
        )
    ]
)
