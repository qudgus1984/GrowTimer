//
//  UserRepository.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol UserRepository {
    func fetchUser() -> [UserEntity]
    func addUser(settingTime: Int)
    func updateUserState(id: UUID, success: Bool)
    
    func yesterdayFilter() -> [UserEntity]
    func todayTotalStudyTime() -> [UserEntity]
    func dayTotalStudyTime(date: Date) -> [UserEntity]
    func todayFilter() -> [UserEntity]
    func dayFilter(date: Date) -> [UserEntity]
    func twoHourTimeFilter(date: Date) -> [UserEntity]
    
    func dayTotalTimeFilter(date: Date) -> Int
    func dayTotalTimeLineFilter(date: Date) -> Int
    func monthTotalTimeFilter(date: Date) -> Int
    func monthCount(date: Date) -> Int
    func successfulRate() -> Int
}
