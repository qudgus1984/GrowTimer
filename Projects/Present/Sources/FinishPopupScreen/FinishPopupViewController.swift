//
//  FinishPopupViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import RxSwift
import ReactorKit

final class FinishPopupViewController: BaseViewController {
    
    let mainview = FinishPopupView()
        
    override func loadView() {
        super.view = mainview
    }
    
    init(reactor: FinishPopupReactor) {
        super.init()
        self.reactor = reactor
    }
}

extension FinishPopupViewController: View {
    func bind(reactor: FinishPopupReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: FinishPopupReactor) {
        
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainview.okButton.rx.tap
            .map { FinishPopupReactor.Action.okButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

    }
    
    private func bindState(reactor: FinishPopupReactor) {
        reactor.state
            .map(\.shouldNavigateToRoot)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.transition(HomeViewController(reactor: HomeReactor()), transitionStyle: .rootViewControllerChange)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.settingTime)
            .bind(with: self) { owner, settingTime in
                print(settingTime)
                owner.mainview.configure(engagedTime: settingTime)
            }
            .disposed(by: disposeBag)
    }
}
