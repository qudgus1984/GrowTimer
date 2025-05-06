//
//  FontEntity.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct FontEntity {
    public var id: UUID
    public var fontName: String
    public var purchase: Bool
    
    public init(
        id: UUID = UUID(),
        fontName: String,
        purchase: Bool = false
    ) {
        self.id = id
        self.fontName = fontName
        self.purchase = purchase
    }
}
