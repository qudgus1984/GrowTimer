//
//  TimeSettingViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import GTToast


// MARK: - View Controller
final class TimeSettingViewController: BaseViewController {
    
    // MARK: Properties
    private let mainView = TimeSettingView()
    
    // MARK: View Lifecycle
    override func loadView() {
        super.view = mainView
    }
    
    // MARK: Initialize
    init(reactor: TimeSettingReactor) {
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

// MARK: - TableView 설정
extension TimeSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension TimeSettingViewController: View {
    func bind(reactor: TimeSettingReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: TimeSettingReactor) {
        // Action
        mainView.tableView.rx.itemSelected
            .map { indexPath in
                TimeSettingEnum.allCases[indexPath.row]
            }
            .map { Reactor.Action.selectTime($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: TimeSettingReactor) {
        // State
        reactor.state
            .map(\.toastMessage)
            .distinctUntilChanged()
            .filter { $0 != nil }
            .bind(with: self, onNext: { owner, message in
                if let message = message {
                    ToastManager.shared.show(message)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.shouldNavigateToRoot }
            .filter { $0 }
            .bind(with: self, onNext: { owner, state in
                owner.transition(HomeViewController(reactor: HomeReactor()), transitionStyle: .rootViewControllerChange)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.timeSettingList)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: TimeSettingTableViewCell.reuseIdentifier, cellType: TimeSettingTableViewCell.self)) { indexPath, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
    }
}
