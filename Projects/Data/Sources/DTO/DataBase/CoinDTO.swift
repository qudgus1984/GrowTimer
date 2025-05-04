//
//  CoinDTO.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import CoreData
import Domain

@objc(CoinDTO)
public class CoinDTO: NSManagedObject {
    @NSManaged public var getCoin: Int
    @NSManaged public var spendCoin: Int
    @NSManaged public var status: Int
    @NSManaged public var now: Date
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      getCoin: Int,
                      spendCoin: Int,
                      status: Int) -> CoinDTO {
        let dto = CoinDTO(context: context)
        dto.id = UUID()
        dto.getCoin = Int(getCoin)
        dto.spendCoin = Int(spendCoin)
        dto.status = Int(status)
        dto.now = Date()
        return dto
    }
}

extension CoinDTO {
    public var toDomain: CoinEntity {
        return CoinEntity(id: id, getCoin: getCoin, spendCoin: spendCoin, status: status, now: now)
    }
}
