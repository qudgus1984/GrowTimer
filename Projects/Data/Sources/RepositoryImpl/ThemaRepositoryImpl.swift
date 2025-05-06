//
//  ThemaRepositoryImpl.swift
//  Data
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import CoreData
import Domain

public final class ThemaRepositoryImpl: ThemaRepository {
    
    private let themaStorage: CoreDataStorage
    
    public init(themaStorage: CoreDataStorage) {
        self.themaStorage = themaStorage
    }

    public func fetchThemaTable() -> [ThemaEntity] {
        let dtos = themaStorage.fetch(ThemaDTO.self)
        return dtos.map { ThemaMapper.toEntity($0) }
    }
    
    public func firstStartThema(themaName: String, purchase: Bool) {
        let _ = ThemaDTO.create(in: themaStorage.mainContext, themaName: themaName, purchase: purchase)
        themaStorage.save()
    }
    
    public func themaBuy(id: UUID) {
        guard let dto = themaStorage.fetchById(ThemaDTO.self, id: id) else { return }
        dto.purchase = true
        themaStorage.save()
    }
}
