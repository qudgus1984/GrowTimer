//
//  MockCoinRepository.swift
//  Domain
//
//  Created by Den on 5/9/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
// 테스트 전용 Mock Repository 구현
class MockCoinRepository: CoinRepository {

    var fetchCoinTableCallCount = 0
    var addCoinCallCount = 0
    var totalCoinCallCount = 0
    
    var coinEntities: [CoinEntity] = []
    var totalCoinValue: Int = 0
    
    var lastAddCoinParams: (getCoin: Int, spendCoin: Int, status: Int)?
    
    func fetchCoinTable() -> [CoinEntity] {
        fetchCoinTableCallCount += 1
        return coinEntities
    }
    
    func addCoin(getCoin: Int, spendCoin: Int, status: Int) {
        addCoinCallCount += 1
        lastAddCoinParams = (getCoin, spendCoin, status)
    }
    
    func totalCoin() -> Int {
        totalCoinCallCount += 1
        return totalCoinValue
    }
}
