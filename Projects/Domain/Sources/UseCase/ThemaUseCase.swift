//
//  ThemaUseCase.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility

public class ThemaUseCase: ThemaUseCaseInterface {

    @Injected private var repository: ThemaRepository
    
    public init() { }
    
    public func excuteFetchThemaTable() -> [ThemaEntity] {
        return repository.fetchThemaTable()
    }
    
    public func excuteFirstStartThema(themaName: String, purcase: Bool) {
        return repository.firstStartThema(themaName: themaName, purchase: purcase)
    }
    
    public func excuteThemaBuy(id: UUID) {
        return repository.themaBuy(id: id)
    }
}
