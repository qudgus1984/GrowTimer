//
//  FontThema.swift
//  DesignSystem
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public enum FontThema: String, CaseIterable {
    case UhBeeFont
    case GangwonFont
    case LeeSeoyunFont
    case SimKyunghaFont

    
    public var Font44: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont44!
        case .GangwonFont:
            return GT.Font.GangwonFont44!
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont44!
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont44!
        
        }
    }
    
    public var Font36: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont36!
        case .GangwonFont:
            return GT.Font.GangwonFont36!
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont36!
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont36!
        }
    }
    
    public var Font24: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont24!
        case .GangwonFont:
            return GT.Font.GangwonFont24!
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont24!
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont24!
        }
    }
    
    public var Font16: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont16!
        case .GangwonFont:
            return GT.Font.GangwonFont16!
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont16!
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont16!
        }
    }
    
    public var Font12: UIFont {
        switch self {
        case .UhBeeFont:
            return GT.Font.UhBeeFont12!
        case .GangwonFont:
            return GT.Font.GangwonFont12!
        case .LeeSeoyunFont:
            return GT.Font.LeeSeoyunFont12!
        case .SimKyunghaFont:
            return GT.Font.SimKyunghaFont12!
        }
    }
}

