//
//  FontDTO.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import CoreData
import Domain

@objc(FontDTO)
public class FontDTO: NSManagedObject {
    @NSManaged public var fontName: String
    @NSManaged public var purchase: Bool
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      fontName: String,
                      purchase: Bool) -> FontDTO {
        let dto = FontDTO(context: context)
        dto.id = UUID()
        dto.fontName = fontName
        dto.purchase = purchase
        return dto
    }
}

extension FontDTO {
    public var toDomain: FontEntity {
        return FontEntity(id: id, fontName: fontName, purchase: purchase)
    }
}
