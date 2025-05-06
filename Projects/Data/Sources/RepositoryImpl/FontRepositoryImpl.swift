//
//  FontRepositoryImpl.swift
//  Data
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import CoreData
import Domain

public final class FontRepositoryImpl: FontRepository {
    
    private let fontStorage: CoreDataStorage

    public init(fontStorage: CoreDataStorage) {
        self.fontStorage = fontStorage
    }

    public func fetchFontTable() -> [FontEntity] {
        let dtos = fontStorage.fetch(FontDTO.self)
        return dtos.map { FontMapper.toEntity($0) }
    }
    
    public func firstStartFont(fontName: String, purchase: Bool) {
        let _ = FontDTO.create(in: fontStorage.mainContext, fontName: fontName, purchase: purchase)
        fontStorage.save()
    }
    
    public func fontBuy(id: UUID) {
        guard let dto = fontStorage.fetchById(FontDTO.self, id: id) else { return }
        dto.purchase = true
        fontStorage.save()
    }
    
}
