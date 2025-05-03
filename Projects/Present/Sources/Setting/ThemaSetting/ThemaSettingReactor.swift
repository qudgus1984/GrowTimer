//
//  ThemaSettingReactor.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary
import DesignSystem

import ReactorKit
import RxSwift

// MARK: - Reactor
final class ThemaSettingReactor: Reactor {
    
    var initialState: State = State()

    // 액션 정의
    enum Action {
        case cellTapped(IndexPath)
    }
    
    // 변이 정의
    enum Mutation {
        case showToast(String)
        case navigateToRoot(Bool)
    }
    
    // 상태 정의
    struct State {
        var showToast: String?
        var shouldNavigateToRoot: Bool = false
        var fontSettingList: [String] = Thema.allCases.map(\.rawValue)
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .cellTapped(let indexPath):
            // 타이머 실행 중인지 확인
            if UserDefaultManager.timerRunning {
                return .just(.showToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!"))
            } else {
                return .concat([
                    .just(.navigateToRoot(true)),
                    .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                ])
            }
        }
    }
    
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .showToast(let message):
            newState.showToast = message
            
        case .navigateToRoot(let navigate):
            newState.shouldNavigateToRoot = navigate
        }
        
        return newState
    }
}
