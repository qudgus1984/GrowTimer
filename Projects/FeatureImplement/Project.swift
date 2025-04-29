//
//  Project.swift
//  AppManifests
//
//  Created by Den on 4/29/25.
//

import ProjectDescription

let project = Project(
    name: "FeatureImplement",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "FeatureImplement",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.featureimplement",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "FeatureInterface", path: "../FeatureInterface"),
            ],
        ),
        Target.target(
            name: "FeatureImplementTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.featureimplement.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "FeatureImplement")
            ]
        )
    ]
)
