//
//  GrowImageManager.swift
//  Utility
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public class GrowImageManager {
    
    private init() { }
    
    public static func changedImage(time: Int) -> UIImage {
        switch time {
        case 0:
            return .seeds
        case 1...7199:
            return .sprout
        case 7200...14399:
            return .blossom
        case 14400...21599:
            return .apple
        case 21600...:
            return .apple
        default:
            return .seeds
        }
    }
}
