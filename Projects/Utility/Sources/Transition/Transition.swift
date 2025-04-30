//
//  Transition.swift
//  Utility
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

// MARK: 화면 전환 설정
extension UIViewController {
    
    public enum TransitionStyle {
        case present // 네비게이션 없이 Present
        case presentNavigation // 네비게이션 임베드 Present
        case presentFullNavigation // 네비게이션 풀스크린
        case push
        case rootViewControllerChange
    }
    
    public func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .rootViewControllerChange:
            changeRootVC(VC: viewController)
        }
    }
    
    func changeRootVC(VC: UIViewController) {
        // UIApplication.shared.windows.first 대신 UIApplication.shared.connectedScenes를 사용한 방식
        // 모듈 간 의존성 없이 window를 찾는 방식
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            // iOS 13 이전 버전 대응 (필요한 경우)
            if let window = UIApplication.shared.windows.first {
                changeRootVC(window: window, viewController: VC)
            }
            return
        }
        
        changeRootVC(window: window, viewController: VC)
    }
    
    private func changeRootVC(window: UIWindow, viewController: UIViewController) {
        let navi = UINavigationController(rootViewController: viewController)
        UIView.transition(with: window, duration: 0.6, options: [.transitionCrossDissolve], animations: {
            window.rootViewController = navi
        }, completion: nil)
        window.makeKeyAndVisible()
    }
}
