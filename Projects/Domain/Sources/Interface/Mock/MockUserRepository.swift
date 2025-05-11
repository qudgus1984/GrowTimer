//
//  MockUserRepository.swift
//  Domain
//
//  Created by Den on 5/10/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

class MockUserRepository: UserRepository {
    // 메서드 호출 여부 추적
    var fetchUserCalled = false
    var addUserCalled = false
    var updateUserStateCalled = false
    var yesterdayFilterCalled = false
    var todayTotalStudyTimeCalled = false
    var dayTotalStudyTimeCalled = false
    var todayFilterCalled = false
    var dayFilterCalled = false
    var twoHourTimeFilterCalled = false
    var dayTotalTimeFilterCalled = false
    var dayTotalTimeLineFilterCalled = false
    var monthTotalTimeFilterCalled = false
    var monthCountCalled = false
    var successfulRateCalled = false
    
    // 메서드에 전달된 파라미터 추적
    var addUserSettingTime: Int?
    var updateUserStateId: UUID?
    var updateUserStateSuccess: Bool?
    var dayTotalStudyTimeDate: Date?
    var dayFilterDate: Date?
    var twoHourTimeFilterDate: Date?
    var dayTotalTimeFilterDate: Date?
    var dayTotalTimeLineFilterDate: Date?
    var monthTotalTimeFilterDate: Date?
    var monthCountDate: Date?
    
    // 메서드 반환값 설정
    var fetchUserReturnValue: [UserEntity] = []
    var yesterdayFilterReturnValue: [UserEntity] = []
    var todayTotalStudyTimeReturnValue: [UserEntity] = []
    var dayTotalStudyTimeReturnValue: [UserEntity] = []
    var todayFilterReturnValue: [UserEntity] = []
    var dayFilterReturnValue: [UserEntity] = []
    var twoHourTimeFilterReturnValue: [UserEntity] = []
    var dayTotalTimeFilterReturnValue: Int = 0
    var dayTotalTimeLineFilterReturnValue: Int = 0
    var monthTotalTimeFilterReturnValue: Int = 0
    var monthCountReturnValue: Int = 0
    var successfulRateReturnValue: Int = 0
    
    func fetchUser() -> [UserEntity] {
        fetchUserCalled = true
        return fetchUserReturnValue
    }
    
    func addUser(settingTime: Int) {
        addUserCalled = true
        addUserSettingTime = settingTime
    }
    
    func updateUserState(id: UUID, success: Bool) {
        updateUserStateCalled = true
        updateUserStateId = id
        updateUserStateSuccess = success
    }
    
    func yesterdayFilter() -> [UserEntity] {
        yesterdayFilterCalled = true
        return yesterdayFilterReturnValue
    }
    
    func todayTotalStudyTime() -> [UserEntity] {
        todayTotalStudyTimeCalled = true
        return todayTotalStudyTimeReturnValue
    }
    
    func dayTotalStudyTime(date: Date) -> [UserEntity] {
        dayTotalStudyTimeCalled = true
        dayTotalStudyTimeDate = date
        return dayTotalStudyTimeReturnValue
    }
    
    func todayFilter() -> [UserEntity] {
        todayFilterCalled = true
        return todayFilterReturnValue
    }
    
    func dayFilter(date: Date) -> [UserEntity] {
        dayFilterCalled = true
        dayFilterDate = date
        return dayFilterReturnValue
    }
    
    func twoHourTimeFilter(date: Date) -> [UserEntity] {
        twoHourTimeFilterCalled = true
        twoHourTimeFilterDate = date
        return twoHourTimeFilterReturnValue
    }
    
    func dayTotalTimeFilter(date: Date) -> Int {
        dayTotalTimeFilterCalled = true
        dayTotalTimeFilterDate = date
        return dayTotalTimeFilterReturnValue
    }
    
    func dayTotalTimeLineFilter(date: Date) -> Int {
        dayTotalTimeLineFilterCalled = true
        dayTotalTimeLineFilterDate = date
        return dayTotalTimeLineFilterReturnValue
    }
    
    func monthTotalTimeFilter(date: Date) -> Int {
        monthTotalTimeFilterCalled = true
        monthTotalTimeFilterDate = date
        return monthTotalTimeFilterReturnValue
    }
    
    func monthCount(date: Date) -> Int {
        monthCountCalled = true
        monthCountDate = date
        return monthCountReturnValue
    }
    
    func successfulRate() -> Int {
        successfulRateCalled = true
        return successfulRateReturnValue
    }
}
