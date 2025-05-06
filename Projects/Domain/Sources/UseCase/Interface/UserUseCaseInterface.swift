//
//  UserUseCaseInterface.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol UserUseCaseInterface {
    func excuteFetchUser() -> [UserEntity]
    func excuteAddUser(settingTime: Int)
    func excuteUpdateUserState(id: UUID, success: Bool)
    
    func excuteYesterdayUserFilter() -> [UserEntity]
    func excuteTodayTotalStudyTime() -> [UserEntity]
    func excuteSpecificDateStudyTime(date: Date) -> [UserEntity]
    func excuteTodayFilter() -> [UserEntity]
    func excuteSpecificDateFilter(date: Date) -> [UserEntity]
    func excuteTwoHoursFilter(date: Date) -> [UserEntity]
    
    func excuteDayTotalTimeFilter(date: Date) -> Int
    func dayTotalTimeLineFilter(date: Date) -> Int
    func monthTotalTimeFilter(date: Date) -> Int
    func monthCount(date: Date) -> Int
    func successfulRate() -> Int
}
