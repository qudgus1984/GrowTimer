//
//  FontRegistration.swift
//  DesignSystem
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

public final class FontRegistration {
    public static func registerFonts() {
        // 폰트 등록 로직
        registerFont(withFilenameString: "강원교육모두 Bold.otf")
        registerFont(withFilenameString: "SimKyungha.otf")
        registerFont(withFilenameString: "LeeSeoyun.otf")
        registerFont(withFilenameString: "UhBee BEOJJI Bold.ttf")
        registerFont(withFilenameString: "UhBee BEOJJI.ttf")
    }
    
    private static func registerFont(withFilenameString filenameString: String) {
        // 번들에서 폰트 파일 찾기
        guard let bundleURL = Bundle(for: FontRegistration.self).url(forResource: filenameString, withExtension: nil) else {
            print("⚠️ 폰트 파일을 찾을 수 없음: \(filenameString)")
            return
        }
        
        // 폰트 등록
        guard let fontDataProvider = CGDataProvider(url: bundleURL as CFURL) else {
            print("⚠️ 폰트 데이터 제공자를 생성할 수 없음: \(filenameString)")
            return
        }
        
        guard let font = CGFont(fontDataProvider) else {
            print("⚠️ CGFont를 생성할 수 없음: \(filenameString)")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("⚠️ 폰트 등록 실패: \(filenameString)")
        }
    }
}
