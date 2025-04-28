//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let project = Project(
    name: "Domain",
    organizationName: "Den",
    packages: [


    ],
    targets: [
        Target.target(
            name: "Domain",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [

            ]
        ),
        Target.target(
            name: "DomainTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.domain.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Domain")
            ]
        )
    ]
)
