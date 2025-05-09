//
//  TimeLineViewController.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import RxSwift
import ReactorKit

final class TimeLineViewController: BaseViewController {
    
    private let mainView = TimeLineView()
    
    override func loadView() {
        view = mainView
    }
    
    init(reactor: TimeLineReactor) {
        super.init()
        self.reactor = reactor
    }
    
    
    override func configureUI() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = ThemaManager.shared.lightColor
        appearence.shadowColor = .clear


        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
    }
}

extension TimeLineViewController: View {
    func bind(reactor: TimeLineReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: TimeLineReactor) {
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: TimeLineReactor) {
        reactor.state
            .map(\.timeLine)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: TimeLineTableViewCell.reuseIdentifier, cellType: TimeLineTableViewCell.self)) { indexPath, item, cell in
                cell.configureTimeLine(item: item)
            }
            .disposed(by: disposeBag)
    }
}

extension TimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}
