//
//  FontSettingViewController.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import Domain
import ThirdPartyLibrary
import DesignSystem

import RxSwift
import RxCocoa
import ReactorKit
import GTToast

final class FontSettingViewController: BaseViewController {
    
    private let mainView = FontSettingView()
    
    // MARK: View Lifecycle
    override func loadView() {
        super.view = mainView
    }
    
    // MARK: Initialize
    init(reactor: FontSettingReactor) {
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

extension FontSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension FontSettingViewController: View {
    func bind(reactor: FontSettingReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    private func bindAction(reactor: FontSettingReactor) {
        let lastSelectedFontEntity =         Observable.zip(
            mainView.tableView.rx.itemSelected,
            mainView.tableView.rx.modelSelected(FontEntity.self)
        )
        // Action
        lastSelectedFontEntity
        .map { indexPath, model in
            return Reactor.Action.cellTappedWithModel(indexPath, model)
        }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)

        
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.alertView.okButton.rx.tap
            .withLatestFrom(lastSelectedFontEntity)
            .map { indexPath, model in
                return Reactor.Action.okButtonTapped(indexPath, model)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.alertView.cancelButton
            .rx.tap
            .map { Reactor.Action.cancelButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    private func bindState(reactor: FontSettingReactor) {
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
            .map(\.alertViewIsHidden)
            .bind(with: self, onNext: { owner, bool in
                owner.mainView.alertView.isHidden = !bool
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
            .map(\.fontTable)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: BaseDesignSettingTableViewCell.reuseIdentifier, cellType: BaseDesignSettingTableViewCell.self)) { indexPath, item, cell in
                cell.configureFont(with: item.fontName, indexPath: indexPath, purchase: item.purchase)
            }
            .disposed(by: disposeBag)
        
    }
}
