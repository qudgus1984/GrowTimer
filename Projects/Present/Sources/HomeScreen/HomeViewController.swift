//
//  HomeViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    private let mainview = HomeView()
    
    override func loadView() {
        super.view = mainview
    }
    
    init(reactor: HomeReactor) {
        super.init()
        self.reactor = reactor
    }
}

extension HomeViewController: View {
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: HomeReactor) {
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: HomeReactor) {
        reactor.state
            .map(\.viewDidLoadTrigger)
            .bind(with: self) { owner, _ in
            }
            .disposed(by: disposeBag)
    }
}

