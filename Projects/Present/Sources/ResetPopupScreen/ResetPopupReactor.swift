//
//  ResetPopupReactor.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary
import Domain
import DesignSystem

import ReactorKit
import RxSwift

public final class ResetPopupReactor: Reactor {
    
    public var initialState = State()
    
    public enum Action {
        case resetButtonTapped
    }
    
    public enum Mutation {
        case navigateToRoot(Bool)
    }
    
    public struct State {
        var shouldNavigateToRoot = false
    }
    
    public init() { }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .resetButtonTapped:
            return .concat([
                .just(.navigateToRoot(true)),
                .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            
        case .navigateToRoot(let shouldNavigateToRoot):
            UserDefaultManager.stopCount = 3
            state.shouldNavigateToRoot = shouldNavigateToRoot
        }
        return state
    }
}
