//
//  ThemaManager.swift
//  Utility
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit
import DesignSystem

public final class ThemaManager {
    
    public static let shared = ThemaManager()
    
    private init() {}
    
    private let themaSerial = UserDefaultManager.thema
    
    private lazy var currentThema = themaChoice(themaNum: themaSerial)
    
    public lazy var mainColor = currentThema.mainColor
    public lazy var lightColor = currentThema.lightColor
    public lazy var progressColor = currentThema.progressColor
    public lazy var calendarChoiceColor = currentThema.calendarChoiceColor
    
    private func themaChoice(themaNum: Int) -> Thema {
        if themaNum == 0 {
            return Thema.SeSACThema
        } else if themaNum == 1 {
            return Thema.PurpleThema
        } else if themaNum == 2 {
            return Thema.PinkThema
        } else if themaNum == 3 {
            return Thema.NightThema
        } else {
            return Thema.BeachThema
        }
    }
}
