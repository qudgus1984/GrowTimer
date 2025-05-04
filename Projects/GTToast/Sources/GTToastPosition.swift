//
//  GTToastPosition.swift
//  GTToast
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
/// Toast가 표시될 위치
public enum GTToastPosition {
    case top
    case center
    case bottom
    
    /// 사용자 정의 위치 (상단으로부터의 Y 위치)
    case custom(CGFloat)
}
