//
//  ToastManager.swift
//  GTToast
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

// ToastStyle.swift
import UIKit

/// Toast의 스타일을 정의하는 구조체
public struct ToastStyle {
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
    public var position: ToastPosition
    
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
                position: ToastPosition = .bottom) {
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

/// Toast가 표시될 위치
public enum ToastPosition {
    case top
    case center
    case bottom
    
    /// 사용자 정의 위치 (상단으로부터의 Y 위치)
    case custom(CGFloat)
}

// ToastView.swift
import UIKit

/// Toast 메시지를 표시하는 뷰
internal final class ToastView: UIView {
    
    // MARK: - Properties
    
    /// Toast 메시지를 표시하는 레이블
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    /// Toast 스타일
    private let style: ToastStyle
    
    // MARK: - Initialization
    
    /// Toast 뷰 초기화
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - style: Toast 스타일
    internal init(message: String, style: ToastStyle) {
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
    private var currentToast: ToastView?
    
    /// 대기 중인 Toast 메시지 큐
    private var queue: [(message: String, duration: TimeInterval, style: ToastStyle)] = []
    
    /// 기본 표시 지속 시간
    public var defaultDuration: TimeInterval = 2.0
    
    /// 기본 스타일
    public var defaultStyle = ToastStyle()
    
    // MARK: - Public Methods
    
    /// Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: defaultDuration)
    ///   - style: Toast 스타일 (기본값: defaultStyle)
    public func show(_ message: String, duration: TimeInterval? = nil, style: ToastStyle? = nil) {
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
    private func showToast(message: String, duration: TimeInterval, style: ToastStyle) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        // Toast 뷰 생성
        let toastView = ToastView(message: message, style: style)
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

// Toast+Extensions.swift
import UIKit

// MARK: - UIViewController Extension

extension UIViewController {
    
    /// 현재 뷰 컨트롤러에서 Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: ToastManager.shared.defaultDuration)
    ///   - style: Toast 스타일 (기본값: ToastManager.shared.defaultStyle)
    public func showToast(_ message: String, duration: TimeInterval? = nil, style: ToastStyle? = nil) {
        ToastManager.shared.show(message, duration: duration, style: style)
    }
}

// MARK: - UIView Extension

extension UIView {
    
    /// 현재 뷰에서 Toast 메시지 표시
    /// - Parameters:
    ///   - message: 표시할 메시지
    ///   - duration: 표시 지속 시간 (기본값: ToastManager.shared.defaultDuration)
    ///   - style: Toast 스타일 (기본값: ToastManager.shared.defaultStyle)
    public func showToast(_ message: String, duration: TimeInterval? = nil, style: ToastStyle? = nil) {
        ToastManager.shared.show(message, duration: duration, style: style)
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
