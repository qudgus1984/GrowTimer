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
        case cellIndex(IndexPath)
    }
    
    struct State {
        var timeSettingEvent: Void = ()
        var thema: Void = ()
        var font: Void = ()
        var settingList = ["집중 시간 설정", "테마 변경/구매", "폰트 변경/구매"]
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {

        case .cellTapped(let indexPath):
                return .just(.cellIndex(indexPath))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .cellIndex(let indexPath):
            if indexPath.row == 0 {
                state.timeSettingEvent = ()
            } else if indexPath.row == 1 {
                state.thema = ()
            } else if indexPath.row == 2 {
                state.font = ()
            } else {
                return state
            }
        }
        return state
    }
}
