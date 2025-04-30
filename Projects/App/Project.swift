//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let project = Project(
    name: "App",
    organizationName: "Den",
    packages: [

    ],
    targets: [
        Target.target(
            name: "App",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "com.den.workchecklist",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [
                            [
                                "UISceneConfigurationName": "Default Configuration",
                                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                            ]
                        ]
                    ]
                ],
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Utility", path: "../Utility"),
                .project(target: "FeatureInterface", path: "../FeatureInterface"),
                .project(target: "FeatureImplement", path: "../FeatureImplement"),
                .project(target: "ThirdPartyLibrary", path: "../ThirdPartyLibrary"),

            ],
//            settings: .settings(
//                base: [
//                    "BUILD_LIBRARY_FOR_DISTRIBUTION": "YES"
//                ]
//            )
        ),
        Target.target(
            name: "AppTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.den.growtimer.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "App")
            ]
        )
    ]
)
