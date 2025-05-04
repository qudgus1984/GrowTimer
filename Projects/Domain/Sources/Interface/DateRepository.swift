//
//  DateRepository.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol DateRepository {
    func dayTotalTimeFilter(date: Date) -> Int
    func dayTotalTimeLineFilter(date: Date) -> Int
    func monthTotalTimeFilter(date: Date) -> Int
    func monthCount(date: Date) -> Int
    func successfulRate() -> Int
}
