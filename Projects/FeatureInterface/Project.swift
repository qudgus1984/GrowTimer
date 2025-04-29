//
//  Project.swift
//  AppManifests
//
//  Created by Den on 4/29/25.
//

import ProjectDescription

let project = Project(
    name: "FeatureInterface",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "FeatureInterface",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.featureinterface",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Present", path: "../Present"),
            ],
        ),
        Target.target(
            name: "FeatureInterfaceTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.featureinterface.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "FeatureInterface")
            ]
        )
    ]
)
