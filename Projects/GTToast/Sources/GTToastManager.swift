//
//  ToastManager.swift
//  GTToast
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

// ToastManager.swift
import UIKit

/// Toast 메시지를 관리하고 표시하는 싱글톤 매니저
public final class ToastManager {
    
    // MARK: - Singleton
    
    /// 공유 인스턴스
    public static let shared = ToastManager()
    
    /// 초기화
    private init() {}
    
    // MARK: - Properties
    
    /// 현재 표시 중인 Toast 뷰
    private var currentToast: GTToastView?
    
    /// 대기 중인 Toast 메시지 큐
    private var queue: [(message: String, duration: TimeInterval, style: GTToastStyle)] = []
    
    /// 기본 표시 지속 시간
    public var defaultDuration: TimeInterval = 2.0
    
    /// 기본 스타일
    public var defaultStyle = GTToastStyle()
    
    // MARK: - Public Methods
    
    /// Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: defaultDuration)
    ///   - style: Toast 스타일 (기본값: defaultStyle)
    public func show(_ message: String, duration: TimeInterval? = nil, style: GTToastStyle? = nil) {
        let duration = duration ?? defaultDuration
        let style = style ?? defaultStyle
        
        // 이미 표시 중인 Toast가 있는 경우 큐에 추가
        if currentToast != nil {
            queue.append((message: message, duration: duration, style: style))
            return
        }
        
        // Toast 표시
        showToast(message: message, duration: duration, style: style)
    }
    
    /// 모든 Toast 메시지 제거
    public func dismissAll() {
        hideCurrentToast()
        queue.removeAll()
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
        currentToast = toastView
        
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
        case .center:
            initialY = window.bounds.height
            finalY = (window.bounds.height - toastSize.height) / 2
        case .bottom:
            initialY = window.bounds.height
            finalY = window.bounds.height - window.safeAreaInsets.bottom - toastSize.height - 16
        case .custom(let yPosition):
            initialY = -toastSize.height
            finalY = yPosition
        }
        
        toastView.frame.origin = CGPoint(
            x: (window.bounds.width - toastSize.width) / 2,
            y: initialY
        )
        
        // 윈도우에 추가
        window.addSubview(toastView)
        
        // 애니메이션으로 표시
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            toastView.frame.origin.y = finalY
        }, completion: { _ in
            // 지정된
            // 지정된 지속 시간 후 사라지도록 설정
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseIn, animations: {
                toastView.frame.origin.y = initialY
                toastView.alpha = 0
            }, completion: { _ in
                self.hideCurrentToast()
                
                // 큐에 다음 Toast가 있는 경우 표시
                if let next = self.queue.first {
                    self.queue.removeFirst()
                    self.showToast(message: next.message, duration: next.duration, style: next.style)
                }
            })
        })
    }
    
    /// 현재 표시 중인 Toast 제거
    private func hideCurrentToast() {
        currentToast?.removeFromSuperview()
        currentToast = nil
    }
}

// 사용 예시:
/*
// 기본 스타일로 표시
self.showToast("기본 Toast 메시지")

// 커스텀 스타일로 표시
let customStyle = ToastStyle(
    backgroundColor: UIColor.systemBlue.withAlphaComponent(0.9),
    textColor: .white,
    font: .boldSystemFont(ofSize: 16),
    cornerRadius: 12,
    position: .top
)
self.showToast("커스텀 Toast 메시지", duration: 3.0, style: customStyle)

// 매니저를 직접 사용
ToastManager.shared.show("매니저를 통한 Toast 메시지")

// 기본 스타일 변경
ToastManager.shared.defaultStyle.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
ToastManager.shared.defaultStyle.position = .center
ToastManager.shared.defaultDuration = 1.5
*/
