//
//  FontRepository.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol FontRepository {
    func fetchFontTable() -> [FontEntity]
    func firstStartFont(fontName: String, purchase: Bool)
    func fontBuy(id: UUID)
}
