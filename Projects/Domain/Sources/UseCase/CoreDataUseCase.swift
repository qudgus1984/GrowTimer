//
//  CoreDataUseCase.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility

public class CoreDataUseCase: CoreDataUseCaseInterface {
    @Injected private var repository: CoreDataRepository
    
    public init() { }
    
    public func excuteGetCoin() -> [CoinEntity] {
        return repository.fetchCoinTable()
    }
    
    public func excuteCreateCoin(_ coin: CoinEntity) {
        repository.addCoin(getCoin: coin.getCoin, spendCoin: coin.spendCoin, status: coin.spendCoin)
    }
}
