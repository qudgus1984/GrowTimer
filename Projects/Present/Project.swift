//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let project = Project(
    name: "Present",
    organizationName: "Den",
    packages: [
    ],
    targets: [
        Target.target(
            name: "Present",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.present",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Utility", path: "../Utility"),
                .project(target: "DesignSystem", path: "../DesignSystem"),
            ]
        ),
        Target.target(
            name: "PresentTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.present.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Present")
            ]
        )
    ]
)
