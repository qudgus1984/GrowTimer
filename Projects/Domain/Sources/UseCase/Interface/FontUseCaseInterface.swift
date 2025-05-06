//
//  FontUseCaseInterface.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol FontUseCaseInterface {
    func excuteFetchFontTable() -> [FontEntity]
    func excuteFirstStartFont(fontName: String, purcase: Bool)
    func excuteFontBuy(id: UUID)
}
