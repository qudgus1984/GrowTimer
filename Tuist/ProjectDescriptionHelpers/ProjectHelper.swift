//
//  Plugin.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

public extension Project {
    static func makeFrameworkTargets(name: String, destinations: Destinations, dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target.target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: "com.den.\(name.lowercased())",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
        
        let tests = Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "com.den.\(name.lowercased()).tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )
        
        return [sources, tests]
    }
    
    static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency] = []) -> [Target] {
        let mainTarget = Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.den.\(name.lowercased())",
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
            dependencies: dependencies
        )
        
        let testTarget = Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "com.den.\(name.lowercased()).tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )
        
        return [mainTarget, testTarget]
    }
}
