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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.transition(FinishPopupViewController(reactor: FinishPopupReactor()), transitionStyle: .presentFullNavigation)
        }
    }
}

extension HomeViewController: View {
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: HomeReactor) {
        // ViewDidLoad 이벤트 발생시키기
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainview.startButton.rx.tap
            .map { Reactor.Action.timerButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: HomeReactor) {
        // 남은 시간 바인딩
        reactor.state
            .map { state -> String in
                let minutes = state.remainingTime / 60
                let seconds = state.remainingTime % 60
                return String(format: "%02d:%02d", minutes, seconds)
            }
            .distinctUntilChanged()
            .bind(to: mainview.countTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 버튼 타이틀 바인딩
        reactor.state
            .map(\.buttonTitle)
            .distinctUntilChanged()
            .bind(to: mainview.startButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        // 프로그레스 바 바인딩
        reactor.state
            .map(\.progress)
            .distinctUntilChanged()
            .bind(with: self) { owner, progress in
                owner.mainview.updateProgress(value: progress)
            }
            .disposed(by: disposeBag)
        
        // 타이머 상태에 따른 UI 업데이트
        reactor.state
            .map(\.isTimerRunning)
            .distinctUntilChanged()
            .bind(with: self) { owner, isRunning in
                owner.mainview.circularProgressBarConfigure(state: isRunning)
            }
            .disposed(by: disposeBag)
        
        // 중지 기회 표시 바인딩
        reactor.state
            .map(\.stopChances)
            .distinctUntilChanged()
            .map { "멈출 수 있는 기회는 \($0)번!" }
            .bind(to: mainview.stopCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 토스트 메시지 바인딩
        reactor.state
            .filter { $0.showToast }
            .map(\.toastMessage)
            .distinctUntilChanged()
            .bind(with: self) { owner, message in
//                owner.mainview.makeToast(message)
            }
            .disposed(by: disposeBag)
            
        // 타이머 완료 시 팝업 표시 바인딩
        reactor.state
            .filter { $0.remainingTime <= 0 && !$0.isTimerRunning }
            .bind(with: self) { owner, _ in
                owner.finishPopupVCAppear()
            }
            .disposed(by: disposeBag)
    }
    
    // 타이머 완료시 팝업 표시 메서드
    func finishPopupVCAppear() {
        // 팝업 표시 로직 구현
        // 예시:
        // let finishPopupVC = FinishPopupViewController()
        // present(finishPopupVC, animated: true)
    }
}
