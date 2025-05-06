//
//  ThemaRepository.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol ThemaRepository {
    func fetchThemaTable() -> [ThemaEntity]
    func firstStartThema(themaName: String, purchase: Bool)
    func themaBuy(id: UUID)
}
