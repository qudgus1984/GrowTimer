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
            bundleId: "com.den.growtimer",
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
                "CFBundleVersion": "1",
                "CFBundleDisplayName": "GrowTimer"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Data", path: "../Data"),
                .project(target: "Utility", path: "../Utility"),
                .project(target: "FeatureInterface", path: "../FeatureInterface"),
                .project(target: "FeatureImplement", path: "../FeatureImplement"),
            ],
            settings: .settings(
                base: [
                    "PRODUCT_NAME": "GrowTimer",
                    "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "RELEASE",
                    // 모든 빌드 구성에 공통으로 적용되는 설정
                ],
                debug: [
                    "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) DEBUG",
                    "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
                    "OTHER_SWIFT_FLAGS": "$(inherited) -D DEBUG",
                    // 추가 디버그 전용 설정
                ],
                release: [
                    "SWIFT_OPTIMIZATION_LEVEL": "-O",
                    // 추가 릴리즈 전용 설정
                ],
                defaultSettings: .recommended
            )
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
