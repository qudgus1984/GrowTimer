//
//  CalendarReactor.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary
import Domain

import ReactorKit
import RxSwift

//final class CalendarReactor: Reactor {
//    
//    @Injected private var userUseCase: UserUseCaseInterface
//
//    var initialState = State()
//    
//    enum Action {
//        case viewDidLoad
//        case fetchCalendarData
//        case selectDate(Date)
//    }
//    
//    enum Mutation {
//        case setUserTasks([UserEntity])
//        case setSelectedDate(Date)
//        case setDailyTasks([UserEntity])
//        case setMonthlySuccessCount(Int)
//        case setDailyTotalTime(Int)
//        case setYesterdayTotalTime(Int)
//    }
//    
//    struct State {
//        var userTasks: [UserEntity] = []
//        var selectedDate: Date = Date()
//        var dailyTasks: [UserEntity] = []
//        var monthlySuccessCount: Int = 0
//        var dailyTotalTime: Int = 0
//        var yesterdayTotalTime: Int = 0
//    }
//    
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .viewDidLoad:
//            
//        case .fetchCalendarData:
//            
//        case .selectDate(let date):
//            
//        }
//    }
//    
//    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
//        return newState
//    }
//}

final class CalendarReactor: Reactor {
    
    @Injected private var userUseCase: UserUseCaseInterface

    var initialState = State()
    
    enum Action {
        case viewDidLoad
        case fetchCalendarData
        case selectDate(Date)
    }
    
    enum Mutation {
        case setUserTasks([UserEntity])
        case setSelectedDate(Date)
        case setDailyTasks([UserEntity])
        case setMonthlySuccessCount(Int)
        case setDailyTotalTime(Int)
        case setYesterdayTotalTime(Int)
    }
    
    struct State {
        var userTasks: [UserEntity] = []
        var selectedDate: Date = Date()
        var dailyTasks: [UserEntity] = []
        var monthlySuccessCount: Int = 0
        var dailyTotalTime: Int = 0
        var yesterdayTotalTime: Int = 0
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                Observable.just(Mutation.setSelectedDate(Date())),
                fetchCalendarData()
            ])
            
        case .fetchCalendarData:
            return fetchCalendarData()
            
        case .selectDate(let date):
            return Observable.concat([
                Observable.just(Mutation.setSelectedDate(date)),
                fetchDailyData(for: date)
            ])
        }
    }
    
    private func fetchCalendarData() -> Observable<Mutation> {
        let tasks = userUseCase.excuteFetchUser()
        return Observable.just(Mutation.setUserTasks(tasks))
    }
    
    private func fetchDailyData(for date: Date) -> Observable<Mutation> {
        let dailyTasks = userUseCase.excuteSpecificDateFilter(date: date)
        let dailyTasksMutation = Observable.just(Mutation.setDailyTasks(dailyTasks))
        
        let dailyTotalTime = userUseCase.excuteDayTotalTimeFilter(date: date)
        let totalTimeMutation = Observable.just(Mutation.setDailyTotalTime(dailyTotalTime))
        
        // 어제 데이터 (하루 전 날짜)
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
        let yesterdayTotalTime = userUseCase.excuteDayTotalTimeFilter(date: yesterdayDate)
        let yesterdayTimeMutation = Observable.just(Mutation.setYesterdayTotalTime(yesterdayTotalTime))
        
        // 해당 달의 성공 횟수
        let monthlyCount = userUseCase.monthCount(date: date)
        let monthlyCountMutation = Observable.just(Mutation.setMonthlySuccessCount(monthlyCount))
        
        return Observable.concat([
            dailyTasksMutation,
            totalTimeMutation,
            yesterdayTimeMutation,
            monthlyCountMutation
        ])
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUserTasks(let tasks):
            newState.userTasks = tasks
            
        case .setSelectedDate(let date):
            newState.selectedDate = date
            
        case .setDailyTasks(let tasks):
            newState.dailyTasks = tasks
            
        case .setMonthlySuccessCount(let count):
            newState.monthlySuccessCount = count
            
        case .setDailyTotalTime(let time):
            newState.dailyTotalTime = time
            
        case .setYesterdayTotalTime(let time):
            newState.yesterdayTotalTime = time
        }
        
        return newState
    }
}
