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
import Domain

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import GTToast

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
        UIApplication.shared.isIdleTimerDisabled = true
        configureNavigationBar()

    }
}

extension HomeViewController: View {
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: HomeReactor) {
        // ViewDidLoad 이벤트 발생시키기
        
        let defaultBrightness = BehaviorRelay<CGFloat>(value: UIScreen.main.brightness)

        viewDidLoadEvent
            .withLatestFrom(defaultBrightness)
            .map { brightness in Reactor.Action.viewDidLoadTrigger(brightness) }
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
                    
        // 타이머 완료 시 팝업 표시 바인딩
        reactor.state
            .map(\.shouldNavigateToFinishPopup)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.transition(FinishPopupViewController(reactor: FinishPopupReactor()), transitionStyle: .presentFullNavigation)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.shouldNavigateToCalendar)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                // 캘린더 화면으로 이동하는 로직
                print("calenderButtonTapped")
                owner.transition(CalendarViewController(reactor: CalendarReactor()), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        // 설정 화면 이동
        reactor.state
            .map(\.shouldNavigateToSetting)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                // 설정 화면으로 이동하는 로직
                owner.transition(SettingViewController(reactor: SettingReactor()), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        // 전구 토글
        reactor.state
            .map(\.screenBrightness)
            .distinctUntilChanged()
            .bind(with: self) { owner, brightness in
                // 전구 토글 로직 (예: 화면 밝기 변경)
                // 불 껐다 켰다 하는 로직이나 다른 기능 구현
                UIScreen.main.brightness = brightness
            }
            .disposed(by: disposeBag)
        
        // 타임라인 화면 이동
        reactor.state
            .map(\.shouldNavigateToTimeLine)
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.transition(TimeLineViewController(reactor: TimeLineReactor()), transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
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
            .map(\.totalCoin)
            .bind(with: self) { owner, coin in
                owner.mainview.totalCoinLabel.text = "\(coin)"
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.todayStudyTime)
            .bind(with: self) { owner, time in
                owner.mainview.iconImageView.image = GrowImageManager.changedImage(time: time)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController {
    func configureNavigationBar() {
        // 네비게이션 바 외관 설정
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = ThemaManager.shared.mainColor
        appearence.shadowColor = .clear
        
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        navigationController?.navigationBar.tintColor = ThemaManager.shared.mainColor
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        // 버튼 생성 - action 메서드 연결 대신 후에 Rx로 바인딩
        let calenderButton = UIBarButtonItem(image: .calendar, style: .plain, target: nil, action: nil)
        calenderButton.tintColor = .white
        
        let settingButton = UIBarButtonItem(image: .setting, style: .plain, target: nil, action: nil)
        settingButton.tintColor = .white
        
        let bulbButton = UIBarButtonItem(image: .lightBulb, style: .plain, target: nil, action: nil)
        bulbButton.tintColor = .white
        
        let timeLineButton = UIBarButtonItem(image: .clock, style: .plain, target: nil, action: nil)
        timeLineButton.tintColor = .white
        
        navigationItem.leftBarButtonItems = [calenderButton]
        navigationItem.rightBarButtonItems = [settingButton, bulbButton, timeLineButton]
        
        // 버튼 이벤트를 Rx로 바인딩
        bindNavigationButtons(
            calenderButton: calenderButton,
            settingButton: settingButton,
            bulbButton: bulbButton,
            timeLineButton: timeLineButton
        )
    }
    
    private func bindNavigationButtons(
        calenderButton: UIBarButtonItem,
        settingButton: UIBarButtonItem,
        bulbButton: UIBarButtonItem,
        timeLineButton: UIBarButtonItem
    ) {
        guard let reactor = self.reactor as? HomeReactor else { return }

        // 캘린더 버튼 바인딩
        calenderButton.rx.tap
            .map { Reactor.Action.calendarButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 설정 버튼 바인딩
        settingButton.rx.tap
            .map { Reactor.Action.settingButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 전구 버튼 바인딩
        bulbButton.rx.tap
            .map { Reactor.Action.bulbButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 타임라인 버튼 바인딩
        timeLineButton.rx.tap
            .map { Reactor.Action.timeLineButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
