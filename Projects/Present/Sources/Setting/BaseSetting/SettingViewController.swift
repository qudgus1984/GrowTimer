//
//  SettingViewController.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import RxSwift
import ReactorKit

final class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    // MARK: View Lifecycle
    override func loadView() {
        super.view = mainView
    }
    
    // MARK: Initialize
    init(reactor: SettingReactor) {
        super.init()
        self.reactor = reactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        mainView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension SettingViewController: View {
    func bind(reactor: SettingReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: SettingReactor) {
        mainView.tableView.rx.itemSelected
            .map { Reactor.Action.cellTapped($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: SettingReactor) {
        reactor.state
            .map(\.settingList)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: TimeSettingTableViewCell.reuseIdentifier, cellType: TimeSettingTableViewCell.self)) { indexPath, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.shouldNavigateToTime)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                // 설정 화면으로 이동하는 로직
                owner.transition(TimeSettingViewController(reactor: TimeSettingReactor(delegate: nil)), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.shouldNavigateToFont)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.transition(FontSettingViewController(reactor: FontSettingReactor()), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.shouldNavigateToThema)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.transition(ThemaSettingViewController(reactor: ThemaSettingReactor()), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
    }
}
