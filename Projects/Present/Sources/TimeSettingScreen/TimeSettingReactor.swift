//
//  TimeSettingReactor.swift
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

protocol SettingTimeDelegate {
    func sendSettingTime(_ time: Int)
}

// MARK: - Reactor
final class TimeSettingReactor: Reactor {
    // 액션 정의
    enum Action {
        case selectTime(TimeSettingEnum)
        case checkTimerRunning
    }
    
    // 변이 정의
    enum Mutation {
        case showToast(String)
        case navigateToRoot
    }
    
    // 상태 정의
    struct State {
        var showToast: String?
        var shouldNavigateToRoot: Bool = false
        var timeSettingList: [String] = TimeSettingEnum.allCases.map(\.rawValue)
    }
    
    var initialState: State = State()
    private let delegate: SettingTimeDelegate?
    
    init(delegate: SettingTimeDelegate?) {
        self.delegate = delegate
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectTime(let timeEnum):
            // 타이머 실행 중인지 확인
//            if UserDefaults.standard.bool(forKey: "going") {
//                return .just(.showToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!"))
//            } else {
            UserDefaultManager.engagedTime = timeEnum.timeSettingValue
                return .concat([
                    .just(.navigateToRoot)
                ])
//            }
            
        case .checkTimerRunning:
            return .empty()
        }
    }
    
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .showToast(let message):
            newState.showToast = message
            
        case .navigateToRoot:
            newState.shouldNavigateToRoot = true
        }
        
        return newState
    }
}

enum TimeSettingEnum: String, CaseIterable {
    case zero = "이정도는 가뿐해! 15분! + 1코인"
    case first = "짧고 굵게!! 30분 + 3코인"
    case second = "데일리한 1시간! + 10코인"
    case third = "집중 하기 좋은 2시간! + 30코인"
    case four = "4시간...도전해볼까요?! + 80코인"
    case five = "8시간!! 켠김에 왕까지?! + 200코인"
    
    var timeSettingValue: Int {
        switch self {
        case .zero:
            return 15*60
        case .first:
            return 30*60
        case .second:
            return 60*60
        case .third:
            return 120*60
        case .four:
            return 240*60
        case .five:
            return 480*60
        }
    }
}
