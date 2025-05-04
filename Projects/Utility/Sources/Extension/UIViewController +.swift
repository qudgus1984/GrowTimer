//
//  UIViewController +.swift
//  Utility
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import ThirdPartyLibrary
import GTToast

extension UIViewController {
    
    public func showToast(_ message: String, duration: TimeInterval? = nil, style: GTToastStyle? = nil) {
        ToastManager.shared.show(message, duration: duration, style: style)
    }
}
