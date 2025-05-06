//
//  CoreDataUseCaseInterface.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol CoreDataUseCaseInterface {
    func excuteGetCoin() -> [CoinEntity]
    func excuteCreateCoin(_ coin: CoinEntity)
}
