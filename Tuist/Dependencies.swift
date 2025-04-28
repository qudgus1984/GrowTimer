//
//  Dependencies.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMajor(from: "3.2.0"))
        ]
    ),
    platforms: [.iOS]
)
