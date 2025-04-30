//
//  FinalPageViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

import ReactorKit
import RxCocoa

final class FinalPageViewController: BaseViewController {
    
    private let mainview = PaginationFinalView()
    
    override func loadView() {
        super.view = mainview
    }
    
    init(reactor: FinalPageReactor) {
        super.init()
        self.reactor = reactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension FinalPageViewController: View {
    func bind(reactor: FinalPageReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: FinalPageReactor) {
        mainview.finishButton.rx.tap
            .map { FinalPageReactor.Action.finishButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: FinalPageReactor) {
        reactor.state
            .map(\.viewDidLoadTrigger)
            .bind(with: self) { owner, _ in
                owner.mainview.configureFinalPageVC()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.rootChangeHomeViewController)
            .bind(with: self) { owner, _ in
                owner.transition(HomeViewController(reactor: HomeReactor()), transitionStyle: .rootViewControllerChange)
            }
            .disposed(by: disposeBag)
    }
}
