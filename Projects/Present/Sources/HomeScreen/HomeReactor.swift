//
//  HomeReactor.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary

import ReactorKit
import RxSwift

final class HomeReactor: Reactor {
    
    var initialState = State()
    private var timer: Disposable? // Rx의 Disposable로 타이머 정의
    
    enum Action {
        case viewDidLoadTrigger(CGFloat)
        case timerButtonTapped
        case timerTick
        case timerCompleted
        // Navigation 관련 Event
        case calendarButtonTapped
        case settingButtonTapped
        case bulbButtonTapped
        case timeLineButtonTapped
    }
    
    enum Mutation {
        case setTimerButtonState(Bool)
        case updateRemainingTime(Int)
        case updateProgress(Float)
        case setButtonTitle(String)
        case resetTimer
        case finishTimer
        case showToast(String)
        case stopChance(Int)
        
        case navigateToCalendar(Bool)
        case navigateToSetting(Bool)
        case toggleBulb
        case navigateToTimeLine(Bool)
    }
    
    struct State {
        var remainingTime: Int = UserDefaultManager.engagedTime
        var progress: Float = 0.0
        var isTimerRunning: Bool = false
        var buttonTitle: String = "시작"
        var stopChances: Int = UserDefaultManager.stopCount
        var firstStartButtonClicked: Bool = true
        var showToast: Bool = false
        var toastMessage: String = ""
        // 전체 시간을 초기화에 저장하여 progress 계산에 사용
        var totalTime: Int = UserDefaultManager.engagedTime
        
        // 필요하다면 네비게이션 관련 상태 추가
        var shouldNavigateToCalendar: Bool = false
        var shouldNavigateToSetting: Bool = false
        var shouldToggleBulb: Bool = false
        var shouldNavigateToTimeLine: Bool = false
        var screenBrightness: CGFloat = UserDefaultManager.bright
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger(let brightNess):
            UserDefaultManager.stopCount = 3
            UserDefaultManager.bright = brightNess
            return .empty()
            
        case .timerButtonTapped:
            if currentState.isTimerRunning {
                // 타이머 중지 로직
                if UserDefaultManager.stopCount > 0 {
                    // 중지 기회가 남아있음
                    timer?.dispose()
                    timer = nil
                    
                    let stopChance = UserDefaultManager.stopCount - 1
                    UserDefaultManager.stopCount = stopChance
                    UserDefaultManager.timerRunning = false

                    return .concat([
                        .just(.setTimerButtonState(false)),
                        .just(.setButtonTitle("시작")),
                        .just(.stopChance(stopChance))
                    ])
                } else {
                    // 중지 기회가 없음 - 토스트 메시지
                    return .just(.showToast("멈출 수 있는 기회를 다 써버렸어요 😣"))
                }
            } else {
                // 타이머 시작 로직
                if currentState.firstStartButtonClicked {
                    // 필요한 경우 저장소 로직 추가
                }
                
                UserDefaultManager.timerRunning = true
                
                // 타이머 Observable 생성 - 1초마다 업데이트
                timer?.dispose() // 기존 타이머가 있다면 해제
                
                // 타이머 로직 수정 - Action을 직접 전달
                timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] _ in
                        guard let self = self else { return }
                        
                        if self.currentState.remainingTime > 0 {
                            self.action.onNext(.timerTick)
                        } else {
                            self.action.onNext(.timerCompleted)
                        }
                    })
                
                return .concat([
                    .just(.setTimerButtonState(true)),
                    .just(.setButtonTitle("중지"))
                ])
            }
            
        case .timerTick:
            let newRemainingTime = currentState.remainingTime - 1
            let progress = Float(newRemainingTime) / Float(currentState.totalTime)
            
            return .concat([
                .just(.updateRemainingTime(newRemainingTime)),
                .just(.updateProgress(1.0 - progress))
            ])
            
        case .timerCompleted:
            timer?.dispose()
            timer = nil
            
            UserDefaultManager.timerRunning = false
            return .concat([
                .just(.setTimerButtonState(false)),
                .just(.setButtonTitle("완료")),
                .just(.resetTimer)
            ])
        case .calendarButtonTapped:
            return .concat([
                .just(.navigateToCalendar(true)),
                .just(.navigateToCalendar(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
            
        case .settingButtonTapped:
            return .concat([
                .just(.navigateToSetting(true)),
                .just(.navigateToSetting(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
            
        case .bulbButtonTapped:
            return .just(.toggleBulb)
            
        case .timeLineButtonTapped:
            return .concat([
                .just(.navigateToTimeLine(true)),
                .just(.navigateToTimeLine(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setTimerButtonState(let isRunning):
            newState.isTimerRunning = isRunning
            
        case .updateRemainingTime(let time):
            newState.remainingTime = time
            
            // 시간이 0이면 타이머 완료 처리
            if time <= 0 {
                newState.buttonTitle = "완료"
                newState.isTimerRunning = false
                newState.firstStartButtonClicked = true
                
                // 기본값으로 재설정
                newState.remainingTime = newState.totalTime
            }
            
        case .updateProgress(let progress):
            newState.progress = progress
            
        case .setButtonTitle(let title):
            newState.buttonTitle = title
            
        case .resetTimer:
            newState.remainingTime = newState.totalTime
            newState.progress = 0.0
            
        case .finishTimer:
            newState.buttonTitle = "완료"
            newState.isTimerRunning = false
            newState.firstStartButtonClicked = true
            
            // 기본값으로 재설정
            newState.remainingTime = newState.totalTime
            
        case .showToast(let message):
            newState.showToast = true
            newState.toastMessage = message
        case .stopChance(let chance):
            newState.stopChances = chance
        case .navigateToCalendar(let navigate):
            newState.shouldNavigateToCalendar = navigate
            return newState
            
        case .navigateToSetting(let navigate):
            newState.shouldNavigateToSetting = navigate
            return newState
        case .toggleBulb:
            newState.shouldToggleBulb.toggle()
            if newState.shouldToggleBulb {
                newState.screenBrightness = 0
            } else {
                newState.screenBrightness = UserDefaultManager.bright
            }
            return newState
            
        case .navigateToTimeLine(let navigate):
            newState.shouldNavigateToTimeLine = navigate
            return newState
        }
        
        return newState
    }
}
