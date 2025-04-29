//
//  AppDelegate+Dependency.swift
//  App
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import FeatureInterface
import FeatureImplement
import Utility

extension AppDelegate {
    func registerDependencies() {
        DIContainer.register(FeatureProviderImplement(), type: FeatureProvider.self)

    }
}
