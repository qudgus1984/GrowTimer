//
//  FinishPopupReactor.swift
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

final class FinishPopupReactor: Reactor {
    
    var initialState = State()
    
    enum Action {
        case viewDidLoadTrigger
        case okButtonTapped
    }
    
    enum Mutation {
        case viewDidLoadTrigger(Void)
        case okButtonTapped(Void)
    }
    
    struct State {
        var viewDidLoadTrigger: Void = ()
        var okButtonTapped: Void = ()
        var settingTime: Int = UserDefaultManager.engagedTime
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.just(.viewDidLoadTrigger(()))
        case .okButtonTapped:
            return Observable.just(.okButtonTapped(()))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
        case .okButtonTapped(let event):
            UserDefaultManager.stopCount = 3
            UserDefaultManager.timerRunning = false
            state.okButtonTapped = event
        }
        return state
    }
}
