//
//  FeatureProvider.swift
//  FeatureImplement
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import FeatureInterface
import Present

public final class FeatureProviderImplement: FeatureProvider {
    
    public init() {  }

    public func createLaunchScreen() -> UIViewController {
        return LaunchScreenViewController()
    }
}
