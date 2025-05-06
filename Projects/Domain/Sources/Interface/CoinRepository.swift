//
//  CoinRepository.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol CoinRepository {
    func fetchCoinTable() -> [CoinEntity]
    func addCoin(getCoin: Int, spendCoin: Int, status: Int)
    func totalCoin() -> Int
}
