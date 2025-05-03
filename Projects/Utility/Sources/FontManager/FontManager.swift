//
//  FontManager.swift
//  Utility
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit
import DesignSystem

public final class FontManager {
    
    public static let shared = FontManager()
    
    private init() {}
    
    private var fontSerial = UserDefaultManager.font
    
    private lazy var currentFontThema = fontChoice(fontNum: fontSerial)
    
    public lazy var font12 = currentFontThema.Font12
    public lazy var font16 = currentFontThema.Font16
    public lazy var font24 = currentFontThema.Font24
    public lazy var font36 = currentFontThema.Font36
    public lazy var font44 = currentFontThema.Font44

    private func fontChoice(fontNum: Int) -> FontThema {
        if fontNum == 0 {
            return FontThema.UhBeeFont
        } else if fontNum == 1 {
            return FontThema.GangwonFont
        } else if fontNum == 2 {
            return FontThema.LeeSeoyunFont
        } else if fontNum == 3 {
            return FontThema.SimKyunghaFont
        } else {
            return FontThema.UhBeeFont
        }
    }
    
    private func fontNewSetting(fontThema: FontThema) {
        self.font12 = fontThema.Font12
        self.font16 = fontThema.Font16
        self.font24 = fontThema.Font24
        self.font36 = fontThema.Font36
        self.font44 = fontThema.Font44
    }
    
    public func fontUpdate(fontNum: Int) {
        fontSerial = fontNum
        UserDefaultManager.font = fontNum
        currentFontThema = fontChoice(fontNum: fontNum)
        fontNewSetting(fontThema: currentFontThema)
    }
}
