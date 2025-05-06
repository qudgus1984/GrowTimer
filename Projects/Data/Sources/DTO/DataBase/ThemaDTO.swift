//
//  ThemaDTO.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import CoreData
import Domain

@objc(ThemaDTO)
public class ThemaDTO: NSManagedObject {
    @NSManaged public var themaName: String
    @NSManaged public var purchase: Bool
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      themaName: String,
                      purchase: Bool) -> ThemaDTO {
        let dto = ThemaDTO(context: context)
        dto.id = UUID()
        dto.themaName = themaName
        dto.purchase = purchase
        return dto
    }
}

extension ThemaDTO {
    public var toDomain: ThemaEntity {
        return ThemaEntity(id: id, themaName: themaName, purchase: purchase)
    }
}
