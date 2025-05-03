//
//  SettingReactor.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary

import ReactorKit
import RxSwift

final class SettingReactor: Reactor {
    
    var initialState = State()
    
    enum Action {
        case cellTapped(IndexPath)
    }
    
    enum Mutation {
        case navigateToTime(Bool)
        case navigateToThema(Bool)
        case navigateToFont(Bool)
    }
    
    struct State {
        var shouldNavigateToTime: Bool = false
        var shouldNavigateToThema: Bool = false
        var shouldNavigateToFont: Bool = false
        var settingList = ["집중 시간 설정", "테마 변경/구매", "폰트 변경/구매"]
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .cellTapped(let indexPath):
            switch indexPath.row {
            case 0:
                return .concat([
                    .just(.navigateToTime(true)),
                    .just(.navigateToTime(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                ])
            case 1:
                return .concat([
                    .just(.navigateToThema(true)),
                    .just(.navigateToThema(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                ])
            case 2:
                return .concat([
                    .just(.navigateToFont(true)),
                    .just(.navigateToFont(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                ])
            default:
                return .empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .navigateToTime(let navigate):
            state.shouldNavigateToTime = navigate
            return state
        case .navigateToFont(let navigate):
            state.shouldNavigateToFont = navigate
            return state
        case .navigateToThema(let navigate):
            state.shouldNavigateToThema = navigate
            return state
        }
    }
}
