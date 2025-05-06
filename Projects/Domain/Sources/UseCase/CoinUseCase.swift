//
//  CoinUseCase.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility

public class CoinUseCase: CoinUseCaseInterface {
    @Injected private var repository: CoinRepository
    
    public init() { }
    
    public func excuteGetCoin() -> [CoinEntity] {
        return repository.fetchCoinTable()
    }
    
    public func excuteCreateCoin(_ coin: CoinEntity) {
        repository.addCoin(getCoin: coin.getCoin, spendCoin: coin.spendCoin, status: coin.status)
    }
    
    public func excuteTotalCoin() -> Int {
        repository.totalCoin()
    }
    
    public func excuteAddCoin(spendTime: Int) -> Int {
        switch spendTime {
        case 60 * 15:
            return 1
        case 60 * 30:
            return 3
        case 60 * 60:
            return 10
        case 60 * 120:
            return 30
        case 60 * 240:
            return 80
        case 60 * 480:
            return 200
        default:
            return 0
        }
    }
    
    public func excuteStatusExplain(status: Int) -> String {
        switch status {
        case 100:
            return "처음 출석하셨습니다."
        case 101:
            return "정해진 시간을 완료하셨습니다."
        case 401:
            return "몽환적 솜사탕 테마💜를 구입하셨습니다."
        case 402:
            return "달콤한 복숭아 테마🍑를 구입하셨습니다."
        case 403:
            return "감성적 밤하늘 테마🌌를 구입하셨습니다."
        case 404:
            return "시원한 바닷가 테마🏖를 구입하셨습니다."
        case 501:
            return "Gangwon 폰트🦋를 구입하셨습니다."
        case 502:
            return "LeeSeoyun 폰트✨를 구입하셨습니다."
        case 503:
            return "Simkyungha 폰트🌃를 구입하셨습니다."
        case 1000:
            return "SeSAC 화이팅🌱"
        case 1001:
            return "쿠폰 코드를 입력하셨습니다."
        case 1002:
            return "♥️"
        case 1003:
            return "콘크리트여 영원하라🧱"
        default:
            return "입력되지 않은 상태코드입니다."
        }
    }
}
