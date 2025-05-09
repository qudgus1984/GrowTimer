//
//  CoinEntity.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct CoinEntity {
    public var id: UUID
    public var getCoin: Int
    public var spendCoin: Int
    public var status: Int
    public var now: Date
    
    public init(id: UUID, getCoin: Int, spendCoin: Int, status: Int, now: Date) {
        self.id = id
        self.getCoin = getCoin
        self.spendCoin = spendCoin
        self.status = status
        self.now = now
    }
}

public extension CoinEntity {
    static let mock: [CoinEntity] = [
        CoinEntity(
            id: UUID(),
            getCoin: 100,
            spendCoin: 0,
            status: 101, // 획득 상태라고 가정
            now: Date()
        ),
        CoinEntity(
            id: UUID(),
            getCoin: 500,
            spendCoin: 0,
            status: 101,
            now: Date().addingTimeInterval(-86400) // 어제
        ),
        CoinEntity(
            id: UUID(),
            getCoin: 0,
            spendCoin: 300,
            status: 502, // 사용 상태라고 가정
            now: Date().addingTimeInterval(-172800) // 이틀 전
        ),
        CoinEntity(
            id: UUID(),
            getCoin: 200,
            spendCoin: 0,
            status: 101,
            now: Date().addingTimeInterval(-259200) // 3일 전
        ),
        CoinEntity(
            id: UUID(),
            getCoin: 0,
            spendCoin: 1000,
            status: 403,
            now: Date().addingTimeInterval(-345600) // 4일 전
        ),
        CoinEntity(
            id: UUID(),
            getCoin: 1000,
            spendCoin: 0,
            status: 101, // 보너스 획득 상태라고 가정
            now: Date().addingTimeInterval(-432000) // 5일 전
        )
    ]
}
