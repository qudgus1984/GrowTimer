//
//  FinalPageReactor.swift
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

final class FinalPageReactor: Reactor {
    
    var initialState = State()
    
    enum Action {
        case viewDidLoadTrigger
        case finishButtonTapped
    }
    
    enum Mutation {
        case viewDidLoadTrigger(Void)
        case firstStartCheck(Bool)
    }
    
    struct State {
        var viewDidLoadTrigger: Void = ()
        var rootChangeHomeViewController: Void = ()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.just(.viewDidLoadTrigger(()))
        case .finishButtonTapped:
            return Observable.just(.firstStartCheck(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
        case .firstStartCheck(let bool):
            UserDefaultManager.start = bool
            state.rootChangeHomeViewController = ()
        }
        return state
    }
}
