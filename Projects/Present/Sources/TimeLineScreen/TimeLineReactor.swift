//
//  TimeLineReactor.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary
import Domain

import ReactorKit
import RxSwift

final class TimeLineReactor: Reactor {
    
    @Injected private var coinUseCase: CoinUseCaseInterface
    @Injected private var userUseCase: UserUseCaseInterface
    
    var initialState = State()
    
    enum Action {
        case viewDidLoadTrigger
    }
    
    enum Mutation {
        case coinTable([CoinEntity])
    }
    
    struct State {
        var timeLine: [TimeLineEntity] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoadTrigger:
            return .just(.coinTable(coinUseCase.excuteGetCoin()))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .coinTable(let coinEntities):
            newState.timeLine = createTimeLineEntities(from: coinEntities).reversed()
        }
        
        return newState
    }
    
    // MARK: - Private Methods
    
    private func createTimeLineEntities(from coinEntities: [CoinEntity]) -> [TimeLineEntity] {
        return coinEntities.map { createTimeLineEntity(from: $0) }
    }
    
    private func createTimeLineEntity(from coin: CoinEntity) -> TimeLineEntity {
        let coinInfo = formatCoinInfo(coin)
        let explainItemInfo = coinUseCase.excuteStatusExplain(status: coin.status)
        let imageNum = userUseCase.dayTotalTimeLineFilter(date: coin.now)
        let dateToString = formatDate(coin.now)
        
        return TimeLineEntity(
            dateToString: dateToString,
            explainItemInfo: explainItemInfo,
            coinInfo: coinInfo,
            imageNum: imageNum
        )
    }
    
    private func formatCoinInfo(_ coin: CoinEntity) -> String {
        if coin.getCoin > 0 {
            return "\(coin.getCoin)코인을 얻었습니다."
        } else {
            return "\(coin.spendCoin)코인을 사용하였습니다."
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd hh:mm"
        return dateFormatter.string(from: date)
    }
}
