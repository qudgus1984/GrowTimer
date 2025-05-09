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
import Domain

import ReactorKit
import RxSwift

final class FinishPopupReactor: Reactor {
    
    @Injected private var coinUseCase: CoinUseCaseInterface
    @Injected private var userUseCase: UserUseCaseInterface
    
    var initialState = State()
    
    enum Action {
        case viewDidLoadTrigger
        case okButtonTapped
    }
    
    enum Mutation {
        case viewDidLoadTrigger(Void)
        case navigateToRoot(Bool)
    }
    
    struct State {
        var viewDidLoadTrigger: Void = ()
        var shouldNavigateToRoot: Bool = false
        var settingTime: Int = UserDefaultManager.engagedTime
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return Observable.just(.viewDidLoadTrigger(()))
        case .okButtonTapped:
            return .concat([
                .just(.navigateToRoot(true)),
                .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .viewDidLoadTrigger(let event):
            state.viewDidLoadTrigger = event
            guard let lastUserId = userUseCase.excuteFetchUser().last?.id else { return state }
            userUseCase.excuteUpdateUserState(id: lastUserId, success: true)
            coinUseCase.excuteCreateCoin(CoinEntity(id: UUID(), getCoin: coinUseCase.excuteAddCoin(spendTime: UserDefaultManager.engagedTime), spendCoin: 0, status: 101, now: .now))
            
        case .navigateToRoot(let navigate):
            UserDefaultManager.stopCount = 3
            UserDefaultManager.timerRunning = false
            state.shouldNavigateToRoot = navigate
        }
        return state
    }
}
