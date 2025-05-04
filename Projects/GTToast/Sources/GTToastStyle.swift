//
//  GTToastStyle.swift
//  GTToast
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

/// Toast의 스타일을 정의하는 구조체
public struct GTToastStyle {
    /// Toast의 배경색
    public var backgroundColor: UIColor
    /// Toast의 텍스트 색상
    public var textColor: UIColor
    /// Toast의 폰트
    public var font: UIFont
    /// Toast의 코너 반경
    public var cornerRadius: CGFloat
    /// Toast의 패딩
    public var contentInset: UIEdgeInsets
    /// Toast의 최대 너비
    public var maxWidth: CGFloat
    /// Toast의 높이 (nil인 경우 콘텐츠에 맞게 자동 조정)
    public var height: CGFloat?
    /// Toast가 표시될 위치
    public var position: GTToastPosition
    
    /// 기본 스타일로 초기화
    public init() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.textColor = .white
        self.font = .systemFont(ofSize: 14)
        self.cornerRadius = 8
        self.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        self.maxWidth = UIScreen.main.bounds.width - 32
        self.height = nil
        self.position = .bottom
    }
    
    /// 커스텀 스타일로 초기화
    public init(backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7),
                textColor: UIColor = .white,
                font: UIFont = .systemFont(ofSize: 14),
                cornerRadius: CGFloat = 8,
                contentInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12),
                maxWidth: CGFloat = UIScreen.main.bounds.width - 32,
                height: CGFloat? = nil,
                position: GTToastPosition = .bottom) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.contentInset = contentInset
        self.maxWidth = maxWidth
        self.height = height
        self.position = position
    }
}
