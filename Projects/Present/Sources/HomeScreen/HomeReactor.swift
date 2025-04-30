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
    
    enum Action {
        case viewDidLoadTrigger
    }
    
    enum Mutation {
        case viewDidLoadTrigger(Void)
    }
    
    struct State {
        var viewDidLoadTrigger: Void = ()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.just((.viewDidLoadTrigger(())))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
        }
        return state
    }
}
