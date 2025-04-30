//
//  Thema.swift
//  DesignSystem
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public enum Thema {
    case SeSACThema
    case PurpleThema
    case PinkThema
    case NightThema
    case BeachThema
    
    public var mainColor: UIColor {
        switch self {
        case .SeSACThema:
            return GT.Color.huntGreen
        case .PurpleThema:
            return GT.Color.huntPurple
        case .PinkThema:
            return GT.Color.huntPink
        case .NightThema:
            return GT.Color.huntNight
        case .BeachThema:
            return GT.Color.huntBeach
        }
    }
    
    public var lightColor: UIColor {
        switch self {
        case .SeSACThema:
            return GT.Color.huntLightGreen
        case .PurpleThema:
            return GT.Color.huntLightPurple
        case .PinkThema:
            return GT.Color.huntLightPink
        case .NightThema:
            return GT.Color.huntLightNight
        case .BeachThema:
            return GT.Color.huntLightBeach
            
        }
    }
    
    public var progressColor: UIColor {
        switch self {
        case .SeSACThema:
            return GT.Color.huntYellow
        case .PurpleThema:
            return GT.Color.huntPurpleWhite
        case .PinkThema:
            return GT.Color.huntPinkWhite
        case .NightThema:
            return GT.Color.huntNightPurple
        case .BeachThema:
            return GT.Color.huntBeachWhite
        }
    }
    
    public var calendarChoiceColor: UIColor {
        switch self {
        case .SeSACThema:
            return GT.Color.customDarkGreen
        case .PurpleThema:
            return GT.Color.huntPurpleBlue
        case .PinkThema:
            return GT.Color.huntPinkRed
        case .NightThema:
            return GT.Color.huntNightPink
        case .BeachThema:
            return GT.Color.huntLightBeachSky
        }
    }
}

