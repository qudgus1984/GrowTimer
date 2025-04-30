//
//  FirstPageViewController.swift
//  Present
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

import SnapKit
import ReactorKit
import RxSwift

final class FirstPageViewController: BaseViewController, View {
    
    private let mainview = PageView()
    
    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reactor = FirstPageReactor()
        self.reactor = reactor
    }
    
    func bind(reactor: FirstPageReactor) {
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.themaNumber }
            .bind(with: self) { owner, num in
                owner.mainview.imageView.backgroundColor = ThemaManager.shared.lightColor
                owner.mainview.bgView.backgroundColor = ThemaManager.shared.mainColor
                owner.mainview.explainLabel.text = "정해진 시간을 완료하고, 나무를 성장시켜보세요!"
                owner.mainview.imageView.image = .appleTree
            }
            .disposed(by: disposeBag)
    }
}
