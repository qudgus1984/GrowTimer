//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let project = Project(
    name: "Utility",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "Utility",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.utility",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "DesignSystem", path: "../DesignSystem"),
                .project(target: "ThirdPartyLibrary", path: "../ThirdPartyLibrary"),
            ],
        ),
        Target.target(
            name: "UtilityTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.utility.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Utility")
            ]
        )
    ]
)
