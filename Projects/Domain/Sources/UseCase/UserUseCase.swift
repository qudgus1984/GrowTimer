//
//  UserUseCase.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility

public final class UserUseCase: UserUseCaseInterface {
    
    @Injected private var repository: UserRepository
    
    public init() {}
    
    public func excuteFetchUser() -> [UserEntity] {
        return repository.fetchUser()
    }
    
    public func excuteAddUser(settingTime: Int) {
        return repository.addUser(settingTime: settingTime)
    }
    
    public func excuteUpdateUserState(id: UUID, success: Bool) {
        return repository.updateUserState(id: id, success: success)
    }
    
    public func excuteYesterdayUserFilter() -> [UserEntity] {
        return repository.yesterdayFilter()
    }
    
    public func excuteTodayTotalStudyTime() -> [UserEntity] {
        return repository.todayTotalStudyTime()
    }
    
    public func excuteSpecificDateStudyTime(date: Date) -> [UserEntity] {
        return repository.dayTotalStudyTime(date: date)
    }
    
    public func excuteTodayFilter() -> [UserEntity] {
        return repository.todayFilter()
    }
    
    public func excuteSpecificDateFilter(date: Date) -> [UserEntity] {
        return repository.dayFilter(date: date)
    }
    
    public func excuteTwoHoursFilter(date: Date) -> [UserEntity] {
        return repository.twoHourTimeFilter(date: date)
    }
    
    public func excuteDayTotalTimeFilter(date: Date) -> Int {
        return repository.dayTotalTimeFilter(date: date)
    }
    
    public func dayTotalTimeLineFilter(date: Date) -> Int {
        return repository.dayTotalTimeLineFilter(date: date)
    }
    
    public func monthTotalTimeFilter(date: Date) -> Int {
        return repository.monthTotalTimeFilter(date: date)
    }
    
    public func monthCount(date: Date) -> Int {
        return repository.monthCount(date: date)
    }
    
    public func successfulRate() -> Int {
        return repository.successfulRate()
    }
}
