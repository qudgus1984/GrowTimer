//
//  MockCoinRepositoryImpl.swift
//  Data
//
//  Created by Den on 5/9/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import XCTest
@testable import Domain

// 테스트를 위한 Mock CoinRepository
public class MockCoinRepository: CoinRepository {
    // 함수 호출 추적을 위한 변수들
    var fetchCoinTableCallCount = 0
    var addCoinCallCount = 0
    var totalCoinCallCount = 0
    
    // 반환할 값들을 설정하는 변수들
    var coinEntities: [CoinEntity] = []
    var totalCoinValue: Int = 0
    
    // 메서드 호출 시 전달된 파라미터 캡처
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
