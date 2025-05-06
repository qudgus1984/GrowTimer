//
//  ThemaUseCaseInterface.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol ThemaUseCaseInterface {
    func excuteFetchThemaTable() -> [ThemaEntity]
    func excuteFirstStartThema(themaName: String, purcase: Bool)
    func excuteThemaBuy(id: UUID)
}
