//
//  UIView +.swift
//  Utility
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import ThirdPartyLibrary
import GTToast

extension UIView {
    
    /// 현재 뷰에서 Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: ToastManager.shared.defaultDuration)
    ///   - style: Toast 스타일 (기본값: ToastManager.shared.defaultStyle)
    public func showToast(_ message: String, duration: TimeInterval? = nil, style: GTToastStyle? = nil) {
        ToastManager.shared.show(message, duration: duration, style: style)
    }
}
