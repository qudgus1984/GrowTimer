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
