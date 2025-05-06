//
//  FontUseCase.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility

public class FontUseCase: FontUseCaseInterface {
    
    @Injected private var repository: FontRepository
        
    public init() { }

    public func excuteFetchFontTable() -> [FontEntity] {
        return repository.fetchFontTable()
    }
    
    public func excuteFirstStartFont(fontName: String, purcase: Bool) {
        return repository.firstStartFont(fontName: fontName, purchase: purcase)
    }
    
    public func excuteFontBuy(id: UUID) {
        return repository.fontBuy(id: id)
    }
}
