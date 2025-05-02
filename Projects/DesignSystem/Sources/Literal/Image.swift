//
//  Image.swift
//  DesignSystem
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

fileprivate enum ImageNameSpace {
    static let appleTree = "apple-tree"
    static let apple = "apple"
    static let appletreeDie = "appletreeDie"
    static let blossom = "blossom"
    static let dollor = "dollar"
    static let seeds = "seeds"
    static let sprout = "sprout"
}
public extension UIImage {
    static var appleTree: UIImage {
        UIImage(named: ImageNameSpace.appleTree, in: .module, compatibleWith: nil)!
    }
    
    static var apple: UIImage {
        UIImage(named: ImageNameSpace.apple, in: .module, compatibleWith: nil)!
    }
    
    static var appletreeDie: UIImage {
        UIImage(named: ImageNameSpace.appletreeDie, in: .module, compatibleWith: nil)!
    }
    
    static var blossom: UIImage {
        UIImage(named: ImageNameSpace.blossom, in: .module, compatibleWith: nil)!
    }
    
    static var dollor: UIImage {
        UIImage(named: ImageNameSpace.dollor, in: .module, compatibleWith: nil)!
    }
    
    static var seeds: UIImage {
        UIImage(named: ImageNameSpace.seeds, in: .module, compatibleWith: nil) ?? UIImage(systemName: "heart.fill")!
    }
    
    static var sprout: UIImage {
        UIImage(named: ImageNameSpace.sprout, in: .module, compatibleWith: nil)!
    }
    
    static var calendar: UIImage {
        UIImage(systemName: "calendar")!
    }
    
    static var lightBulb: UIImage {
        UIImage(systemName: "lightbulb")!
    }
    
    static var setting: UIImage {
        UIImage(systemName: "gearshape.fill")!
    }
    
    static var clock: UIImage {
        UIImage(systemName: "clock.fill")!
    }
}
