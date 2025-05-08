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
        case firstIndexData(String)
        case secondIndexData(String)
        case thirdIndexData(String)
    }
    
    struct State {
        var userTasks: [UserEntity] = []
        var selectedDate: Date = Date()
        var dailyTasks: [UserEntity] = []
        var monthlySuccessCount: Int = 0
        var dailyTotalTime: Int = 0
        var yesterdayTotalTime: Int = 0
        var firstIndexText: String = ""
        var secondIndexText: String = ""
        var thirdIndexText: String = ""
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.concat([
                
                fetchCalendarData(),
                fetchSelectedData(for: Date())
            ])
            
        case .fetchCalendarData:
            return fetchCalendarData()
            
        case .selectDate(let date):

            return Observable.concat([
                Observable.just(Mutation.setSelectedDate(date)),
                fetchSelectedData(for: date)
            ])
        }
    }
    
    private func fetchCalendarData() -> Observable<Mutation> {
        let tasks = userUseCase.excuteFetchUser()
        return Observable.just(Mutation.setUserTasks(tasks))
    }
    
    private let koreanCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return calendar
    }()

    // 이제 위에서 선언한 koreanCalendar를 사용하는 함수
    private func normalizeToKoreanMidnight(date: Date) -> Date {
        let components = koreanCalendar.dateComponents([.year, .month, .day], from: date)
        return koreanCalendar.date(from: components)!
    }
    
    private func fetchSelectedData(for date: Date) -> Observable<Mutation> {
        
        let krDate = normalizeToKoreanMidnight(date: date)
        let nowKrDate = normalizeToKoreanMidnight(date: Date())
        
        print("@@@@",krDate, nowKrDate)
        if userUseCase.excuteSpecificDateFilter(date: krDate).isEmpty {
            let hour = userUseCase.excuteDayTotalTimeFilter(date: nowKrDate) / 60
            let minutes = userUseCase.excuteDayTotalTimeFilter(date: nowKrDate) % 60
            
            var firstIndexData = ""
            if hour == 0 {
                firstIndexData = "오늘 \(minutes) 분 만큼 성장하셨네요"
            } else {
                firstIndexData = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            }
            
            let secondIndexData = "어제는 성장하지 않았습니다!"
            let thirdIndexData = "이번달에는 \(userUseCase.monthCount(date: nowKrDate))번 성공하셨습니다 👍🏻"
            return Observable.concat(
                Observable.just(.firstIndexData(firstIndexData)),
                Observable.just(.secondIndexData(secondIndexData)),
                Observable.just(.thirdIndexData(thirdIndexData))
            )
        } else {
            let hour = userUseCase.excuteDayTotalTimeFilter(date: nowKrDate) / 60
            let minutes = userUseCase.excuteDayTotalTimeFilter(date: nowKrDate) % 60
            
            let removeNum = userUseCase.excuteDayTotalTimeFilter(date: nowKrDate) - userUseCase.excuteDayTotalTimeFilter(date: nowKrDate - 86400)
            let removehour = removeNum / 60
            let removeminutes = removeNum % 60
            
            print(removeNum, removehour, removeminutes)
            let firstIndexData = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            
            var secondIndexData = ""
            if removeNum < 0 {
                secondIndexData = "어제보다 \(-removehour)시간 \(-removeminutes)분 덜 했어요 😭"
            } else if removeNum > 0 {
                secondIndexData = "어제보다 \(removehour)시간 \(removeminutes)분 더 나아갔어요!"
            } else {
                secondIndexData = "한결같은 당신의 꾸준함을 응원합니다 :D"
            }
            let thirdIndexData = "이번 달에는 \(userUseCase.monthCount(date: nowKrDate))번 성공하셨어요 👍🏻"

            return Observable.concat(
                Observable.just(.firstIndexData(firstIndexData)),
                Observable.just(.secondIndexData(secondIndexData)),
                Observable.just(.thirdIndexData(thirdIndexData))
            )
        }
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
        case .firstIndexData(let text):
            newState.firstIndexText = text
        case .secondIndexData(let text):
            newState.secondIndexText = text
        case .thirdIndexData(let text):
            newState.thirdIndexText = text
        }
        return newState
    }
}
