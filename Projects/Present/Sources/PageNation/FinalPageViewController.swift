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

final class FinalPageViewController: BaseViewController, View {
    
    private let mainview = PaginationFinalView()
    
    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let reactor = FinalPageReactor()
        self.reactor = reactor
    }
    
    func bind(reactor: FinalPageReactor) {
        mainview.finishButton.rx.tap
            .map { FinalPageReactor.Action.finishButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.viewDidLoadTrigger }
            .bind(with: self) { owner, _ in
                owner.mainview.explainLabel.text = "보유한 코인으로 테마나 폰트를 구입할 수 있어요!\n(출석 시 + 10코인)"
                owner.mainview.imageView.image = .dollor
            }
            .disposed(by: disposeBag)
    }
}

