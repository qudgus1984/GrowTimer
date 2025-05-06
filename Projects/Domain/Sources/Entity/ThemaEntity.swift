//
//  ThemaEntity.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct ThemaEntity {
    public var id: UUID
    public var themaName: String
    public var purchase: Bool
    
    public init(
        id: UUID = UUID(),
        themaName: String,
        purchase: Bool = false
    ) {
        self.id = id
        self.themaName = themaName
        self.purchase = purchase
    }
}
