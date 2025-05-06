//
//  ResetPopupViewController.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import ThirdPartyLibrary
import Utility

import ReactorKit
import RxSwift

public final class ResetPopupViewController: BaseViewController {
    
    private let mainview = ResetPopupView()
    
    public init(reactor: ResetPopupReactor) {
        super.init()
        self.reactor = reactor
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                        
    }
    
    public override func loadView() {
        super.view = mainview
    }
    
    public override func configureUI() {
                
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemGray
        appearence.shadowColor = .clear

        
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence

        
    }
}

extension ResetPopupViewController: View {
    public func bind(reactor: ResetPopupReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: ResetPopupReactor) {
        mainview.startButton.rx.tap
            .map { Reactor.Action.resetButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: ResetPopupReactor) {
        reactor.state
            .map(\.shouldNavigateToRoot)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                // 설정 화면으로 이동하는 로직
                owner.transition(HomeViewController(reactor: HomeReactor()), transitionStyle: .rootViewControllerChange)
            }
            .disposed(by: disposeBag)
    }
}
