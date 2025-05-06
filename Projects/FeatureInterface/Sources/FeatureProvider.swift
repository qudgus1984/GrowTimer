//
//  DefaultFeatureProvider.swift
//  FeatureInterface
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public protocol FeatureProvider {
    func createLaunchScreen() -> UIViewController
    
    func createResetPopupScreen() -> UIViewController
}
