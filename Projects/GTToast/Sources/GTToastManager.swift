//
//  ToastManager.swift
//  GTToast
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

// ToastManager.swift
import UIKit

public final class ToastManager {
    
    // MARK: - Singleton
    
    /// 공유 인스턴스
    public static let shared = ToastManager()
    
    /// 초기화
    private init() {}
    
    // MARK: - Properties
    
    /// 현재 표시 중인 Toast 뷰들
    private var activeToasts: [GTToastView] = []
    
    /// 기본 표시 지속 시간
    public var defaultDuration: TimeInterval = 2.0
    
    /// 기본 스타일
    public var defaultStyle = GTToastStyle()
    
    /// Toast 간 수직 간격
    private let toastSpacing: CGFloat = 8
    
    // MARK: - Public Methods
    
    /// Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: defaultDuration)
    ///   - style: Toast 스타일 (기본값: defaultStyle)
    public func show(_ message: String, duration: TimeInterval? = nil, style: GTToastStyle? = nil) {
        let duration = duration ?? defaultDuration
        let style = style ?? defaultStyle
        
        // 새로운 Toast 즉시 표시
        showToast(message: message, duration: duration, style: style)
    }
    
    /// 모든 Toast 메시지 제거
    public func dismissAll() {
        for toast in activeToasts {
            toast.removeFromSuperview()
        }
        activeToasts.removeAll()
    }
    
    // MARK: - Private Methods
    
    /// Toast 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간
    ///   - style: Toast 스타일
    private func showToast(message: String, duration: TimeInterval, style: GTToastStyle) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        // Toast 뷰 생성
        let toastView = GTToastView(message: message, style: style)
        
        // 크기 및 위치 계산
        let toastSize = toastView.sizeThatFits()
        toastView.frame.size = toastSize
        
        // 초기 위치 계산 (화면 밖에서 시작)
        var initialY: CGFloat = 0
        var finalY: CGFloat = 0
        
        switch style.position {
        case .top:
            initialY = -toastSize.height
            finalY = window.safeAreaInsets.top + 16
            
            // 이미 표시 중인 Toast가 있는 경우 아래로 위치 조정
            if !activeToasts.isEmpty {
                let topToasts = activeToasts.filter {
                    if case .top = $0.style.position { return true }
                    return false
                }
                
                if let lastToast = topToasts.last {
                    finalY = lastToast.frame.maxY + toastSpacing
                }
            }
            
        case .center:
            initialY = window.bounds.height
            finalY = (window.bounds.height - toastSize.height) / 2
            
            // 중앙에 표시되는 Toast는 겹치지 않도록 약간씩 위치 조정
            let centerOffset: CGFloat = CGFloat(activeToasts.count % 3) * 20
            finalY += centerOffset - 20
            
        case .bottom:
            initialY = window.bounds.height
            finalY = window.bounds.height - window.safeAreaInsets.bottom - toastSize.height - 16
            
            // 이미 표시 중인 Toast가 있는 경우 위로 위치 조정
            if !activeToasts.isEmpty {
                let bottomToasts = activeToasts.filter {
                    if case .bottom = $0.style.position { return true }
                    return false
                }
                
                for toast in bottomToasts {
                    toast.frame.origin.y -= (toastSize.height + toastSpacing)
                }
            }
            
        case .custom(let yPosition):
            initialY = -toastSize.height
            finalY = yPosition
        }
        
        toastView.frame.origin = CGPoint(
            x: (window.bounds.width - toastSize.width) / 2,
            y: initialY
        )
        
        // 활성 Toast 배열에 추가
        activeToasts.append(toastView)
        
        // 윈도우에 추가
        window.addSubview(toastView)
        
        // 애니메이션으로 표시
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            toastView.frame.origin.y = finalY
        }, completion: { _ in
            // 지정된 지속 시간 후 사라지도록 설정
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { _ in
                // Toast 제거
                if let index = self.activeToasts.firstIndex(where: { $0 === toastView }) {
                    self.activeToasts.remove(at: index)
                }
                toastView.removeFromSuperview()
            })
        })
    }
}
