//
//  Project.swift
//  AppManifests
//
//  Created by Den on 4/28/25.
//

import ProjectDescription

let project = Project(
    name: "DesignSystem",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "DesignSystem",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.designsystem",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
            ],
        ),
        Target.target(
            name: "DesignSystemTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.designsystem.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "DesignSystem")
            ]
        )
    ]
)
