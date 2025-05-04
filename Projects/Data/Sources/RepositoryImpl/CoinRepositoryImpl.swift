//
//  CoinRepositoryImpl.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import CoreData
import Domain

public final class CoinRepositoryImpl: CoinRepository {
    
    private let coinStorage: CoreDataStorage

    public init(coinStorage: CoreDataStorage) {
        self.coinStorage = coinStorage
    }
    
    public func fetchCoinTable() -> [Domain.CoinEntity] {
        let dtos = coinStorage.fetch(CoinDTO.self)
        return dtos.map { CoinMapper.toEntity($0) }
    }
    
    public func addCoin(getCoin: Int, spendCoin: Int, status: Int) {
        let _ = CoinDTO.create(in: coinStorage.mainContext, getCoin: Int32(getCoin), spendCoin: Int32(spendCoin), status: Int16(status))
        coinStorage.save()
    }
    
    public func totalCoin() -> Int {
        let dtos = coinStorage.fetch(CoinDTO.self)
        return Int(dtos.reduce(0) { $0 + $1.getCoin - $1.spendCoin })
    }
}
