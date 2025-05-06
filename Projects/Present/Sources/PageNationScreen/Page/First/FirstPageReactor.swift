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
        case viewDidLoadTrigger(Void)
    }
    
    struct State {
        var themaNumber: Int = 0
        var viewDidLoadTrigger: Void = ()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.concat([
                Observable.just(.viewDidLoadTrigger(())),
                Observable.just(.themaVale(UserDefaultManager.thema))
                
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .themaVale(let themaNumber):
            state.themaNumber = themaNumber
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
        }
        return state
    }
}
