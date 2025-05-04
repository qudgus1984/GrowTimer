//
//  Project.swift
//  AppManifests
//
//  Created by Den on 5/3/25.
//

import ProjectDescription

let project = Project(
    name: "GTToast",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "GTToast",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.gttoast",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
            ],
        ),
        Target.target(
            name: "GTToastTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.toast.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "GTToast")
            ]
        )
    ]
)
