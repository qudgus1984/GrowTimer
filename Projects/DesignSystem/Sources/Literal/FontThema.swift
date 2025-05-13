//
//  FontThema.swift
//  DesignSystem
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public enum FontThema: String, CaseIterable {
    case UhBeeFont = "UhBee 폰트 🦋"
    case GangwonFont = "Gangwon 폰트 🌊"
    case LeeSeoyunFont = "LeeSeoyun 폰트 ✨"
    case SimKyunghaFont = "SimKyungha 폰트 🌃"

    public var Font44: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont44 ?? UIFont.systemFont(ofSize: 44)
        case .GangwonFont:
            return GT.Font.GangwonFont44 ?? UIFont.systemFont(ofSize: 44)
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont44 ?? UIFont.systemFont(ofSize: 44)
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont44 ?? UIFont.systemFont(ofSize: 44)
        }
    }
    
    public var Font36: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont36 ?? UIFont.systemFont(ofSize: 36)
        case .GangwonFont:
            return GT.Font.GangwonFont36 ?? UIFont.systemFont(ofSize: 36)
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont36 ?? UIFont.systemFont(ofSize: 36)
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont36 ?? UIFont.systemFont(ofSize: 36)
        }
    }
    
    public var Font24: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont24 ?? UIFont.systemFont(ofSize: 24)
        case .GangwonFont:
            return GT.Font.GangwonFont24 ?? UIFont.systemFont(ofSize: 24)
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont24 ?? UIFont.systemFont(ofSize: 24)
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont24 ?? UIFont.systemFont(ofSize: 24)
        }
    }
    
    public var Font16: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont16 ?? UIFont.systemFont(ofSize: 16)
        case .GangwonFont:
            return GT.Font.GangwonFont16 ?? UIFont.systemFont(ofSize: 16)
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont16 ?? UIFont.systemFont(ofSize: 16)
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont16 ?? UIFont.systemFont(ofSize: 16)
        }
    }
    
    public var Font12: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont12 ?? UIFont.systemFont(ofSize: 12)
        case .GangwonFont:
            return GT.Font.GangwonFont12 ?? UIFont.systemFont(ofSize: 12)
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont12 ?? UIFont.systemFont(ofSize: 12)
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont12 ?? UIFont.systemFont(ofSize: 12)
        }
    }
}
