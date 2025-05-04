//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let project = Project(
    name: "Data",
    organizationName: "Den",
    targets: [
        Target.target(
            name: "Data",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.den.growtimer.data",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [
                "Resources/**",
                // 명시적으로 CoreData 모델 추가
                "CoinDTO.xcdatamodeld",
                "FontDataModel.xcdatamodeld",
                "ThemaDataModel.xcdatamodeld",
                "UserDataModel.xcdatamodeld"
            ],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Utility", path: "../Utility")
            ]
        ),
        Target.target(
            name: "DataTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.data.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Data")
            ]
        )
    ]
)
