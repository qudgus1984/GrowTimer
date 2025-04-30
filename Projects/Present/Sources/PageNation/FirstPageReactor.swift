//
//  FirstPageReactor.swift
//  Present
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary

import ReactorKit
import RxSwift

final class FirstPageReactor: Reactor {
    
    var initialState = State()
    
    enum Action {
        case viewDidLoadTrigger
    }
    
    enum Mutation {
        case themaVale(Int)
    }
    
    struct State {
        var themaNumber: Int = 0
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            Observable.just(.themaVale(UserDefaultManager.thema))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .themaVale(let themaNumber):
            state.themaNumber = themaNumber
        }
        return state
    }
}
