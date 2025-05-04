//
//  GTToastView.swift
//  GTToast
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

/// Toast 메시지를 표시하는 뷰
internal final class GTToastView: UIView {
    
    // MARK: - Properties
    
    /// Toast 메시지를 표시하는 레이블
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    /// Toast 스타일
    private let style: GTToastStyle
    
    // MARK: - Initialization
    
    /// Toast 뷰 초기화
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - style: Toast 스타일
    internal init(message: String, style: GTToastStyle) {
        self.style = style
        super.init(frame: .zero)
        
        setupView()
        configureLabel(with: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    /// 뷰 설정
    private func setupView() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        clipsToBounds = true
        
        addSubview(messageLabel)
        
        // 그림자 설정
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    /// 레이블 구성
    /// - Parameter message: 표시할 메시지
    private func configureLabel(with message: String) {
        messageLabel.text = message
        messageLabel.font = style.font
        messageLabel.textColor = style.textColor
        
        setNeedsLayout()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageLabel.frame = bounds.inset(by: style.contentInset)
    }
    
    // MARK: - Size Calculation
    
    /// 주어진 메시지에 대한 크기 계산
    /// - Returns: 계산된 크기
    internal func sizeThatFits() -> CGSize {
        let maxLabelWidth = style.maxWidth - style.contentInset.left - style.contentInset.right
        
        let labelSize = messageLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: .greatestFiniteMagnitude))
        
        let width = min(labelSize.width + style.contentInset.left + style.contentInset.right, style.maxWidth)
        let height = style.height ?? (labelSize.height + style.contentInset.top + style.contentInset.bottom)
        
        return CGSize(width: width, height: height)
    }
}
