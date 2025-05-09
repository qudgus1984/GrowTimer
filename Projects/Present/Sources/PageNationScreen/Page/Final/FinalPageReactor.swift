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
        case navigateToHome(Bool)
    }
    
    struct State {
        var viewDidLoadTrigger: Void = ()
        var rootChangeHomeViewController: Bool = false
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.just(.viewDidLoadTrigger(()))
        case .finishButtonTapped:
            return .concat([
                .just(.navigateToHome(true)),
                .just(.navigateToHome(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
        case .navigateToHome(let bool):
            UserDefaultManager.start = true
            state.rootChangeHomeViewController = bool
        }
        return state
    }
}
