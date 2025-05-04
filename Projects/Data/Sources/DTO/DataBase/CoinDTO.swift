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
    @NSManaged public var getCoin: Int32  // Int 대신 Int32 사용
    @NSManaged public var spendCoin: Int32
    @NSManaged public var status: Int16  // Integer 16에 맞게 Int16으로 변경
    @NSManaged public var now: Date
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      getCoin: Int32,
                      spendCoin: Int32,
                      status: Int16) -> CoinDTO {
        guard let entity = NSEntityDescription.entity(forEntityName: "CoinDTO", in: context) else {
            fatalError("CoinDTO 엔티티를 찾을 수 없습니다")
        }
        let dto = CoinDTO(entity: entity, insertInto: context)
        dto.id = UUID()
        dto.getCoin = getCoin
        dto.spendCoin = spendCoin
        dto.status = status
        dto.now = Date()
        return dto
    }
}

extension CoinDTO {
    public var toDomain: CoinEntity {
        return CoinEntity(id: id, getCoin: Int(getCoin), spendCoin: Int(spendCoin), status: Int(status), now: now)
    }
}
