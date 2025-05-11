//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import Foundation
import Utility
import XCTest
@testable import Domain

class CoinUseCaseTests: XCTestCase {

    var sut: CoinUseCase!
    
    var mockRepository: MockCoinRepository!
    
    override func setUp() {
        super.setUp()
        
        // DIContainer 초기화 및 Mock 등록
        DIContainer.setupForTesting()
        
        mockRepository = MockCoinRepository()
        
        DIContainer.register(mockRepository, type: CoinRepository.self)
        
        sut = CoinUseCase()
    }
    
    override func tearDown() {
        DIContainer.tearDownTesting()
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
        
    // MARK: - excuteGetCoin 테스트
    func testExcuteGetCoin_ReturnsCoinsFromRepository() {
        mockRepository.coinEntities = CoinEntity.mock
        
        let result = sut.excuteGetCoin()
        
        XCTAssertEqual(mockRepository.fetchCoinTableCallCount, 1, "fetchCoinTable should be called once")
        XCTAssertEqual(result.count, CoinEntity.mock.count, "Should return the expected number of coins")
    }
    
    // MARK: - excuteCreateCoin 테스트
    
    func testExcuteCreateCoin_CallsRepositoryWithCorrectParameters() {
        let testCoin = CoinEntity.mock[0]
        
        sut.excuteCreateCoin(testCoin)
        
        XCTAssertEqual(mockRepository.addCoinCallCount, 1, "addCoin should be called once")
        XCTAssertEqual(mockRepository.lastAddCoinParams?.getCoin, testCoin.getCoin, "getCoin parameter should be correct")
        XCTAssertEqual(mockRepository.lastAddCoinParams?.spendCoin, testCoin.spendCoin, "spendCoin parameter should be correct")
        XCTAssertEqual(mockRepository.lastAddCoinParams?.status, testCoin.status, "status parameter should be correct")
    }
    
    // MARK: - excuteTotalCoin 테스트
    
    func testExcuteTotalCoin_ReturnsValueFromRepository() {
        mockRepository.totalCoinValue = 500
        
        let result = sut.excuteTotalCoin()
        
        XCTAssertEqual(mockRepository.totalCoinCallCount, 1, "totalCoin should be called once")
        XCTAssertEqual(result, 500, "Should return the expected total coin value")
    }
    
    // MARK: - excuteAddCoin 테스트
    
    func testExcuteAddCoin_ReturnsCorrectValueForDifferentSpendTimes() {
        let testCases = [
            (60 * 15, 1),
            (60 * 30, 3),
            (60 * 60, 10),
            (60 * 120, 30),
            (60 * 240, 80),
            (60 * 480, 200),
            (42, 0)
        ]
        
        for (spendTime, expectedCoins) in testCases {
            let result = sut.excuteAddCoin(spendTime: spendTime)
            XCTAssertEqual(result, expectedCoins, "For spendTime \(spendTime), should return \(expectedCoins) coins")
        }
    }
    
    // MARK: - excuteStatusExplain 테스트
    
    func testExcuteStatusExplain_ReturnsCorrectStringForDifferentStatuses() {
        let testCases = [
            (100, "처음 출석하셨습니다."),
            (101, "정해진 시간을 완료하셨습니다."),
            (401, "몽환적 솜사탕 테마💜를 구입하셨습니다."),
            (999, "입력되지 않은 상태코드입니다.") // 기본값 케이스
        ]
        
        for (status, expectedExplanation) in testCases {
            let result = sut.excuteStatusExplain(status: status)
            
            XCTAssertEqual(result, expectedExplanation, "For status \(status), should return \"\(expectedExplanation)\"")
        }
    }
}
