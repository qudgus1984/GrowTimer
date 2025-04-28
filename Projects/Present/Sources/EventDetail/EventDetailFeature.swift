//
//  EventDetailFeature.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

@Reducer
struct EventDetailFeature {
    struct State: Equatable {
        var event: Event
        var isEditing: Bool
        
        init(event: Event, isEditing: Bool = false) {
            self.event = event
            self.isEditing = isEditing
        }
    }
    
    enum Action {
        case editButtonTapped
        case saveEvent(Event)
        case deleteEvent
        case updateEvent(Event)
        case cancelEditing
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .editButtonTapped:
                state.isEditing = true
                return .none
                
            case let .saveEvent(event):
                state.event = event
                state.isEditing = false
                return .none
                
            case .deleteEvent:
                return .none
                
            case let .updateEvent(event):
                state.event = event
                return .none
                
            case .cancelEditing:
                state.isEditing = false
                return .none
            }
        }
    }
}

// Features/EventCreation/EventCreationFeature.swift
//import Foundation
//import ComposableArchitecture

@Reducer
struct EventCreationFeature {
    struct State: Equatable {
        var event: Event
        
        init(event: Event) {
            self.event = event
        }
    }
    
    enum Action {
        case saveEvent(Event)
        case updateEvent(Event)
        case cancelCreation
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .saveEvent(event):
                state.event = event
                return .none
                
            case let .updateEvent(event):
                state.event = event
                return .none
                
            case .cancelCreation:
                return .none
            }
        }
    }
}

// Features/MonthSelection/MonthSelectionFeature.swift
import Foundation
import ComposableArchitecture

@Reducer
struct MonthSelectionFeature {
    struct State: Equatable {
        var selectedDate: Date
        var displayedYear: Int
        var months: [Date]
        
        init(selectedDate: Date) {
            self.selectedDate = selectedDate
            
            let calendar = Calendar.current
            self.displayedYear = calendar.component(.year, from: selectedDate)
            
            // 현재 년도의 12개월 생성
            var months = [Date]()
            for month in 1...12 {
                var components = DateComponents()
                components.year = displayedYear
                components.month = month
                components.day = 1
                
                if let date = calendar.date(from: components) {
                    months.append(date)
                }
            }
            
            self.months = months
        }
    }
    
    enum Action {
        case monthSelected(Date)
        case previousYear
        case nextYear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .monthSelected(date):
                state.selectedDate = date
                return .none
                
            case .previousYear:
                state.displayedYear -= 1
                
                // 이전 년도의 12개월 생성
                var months = [Date]()
                for month in 1...12 {
                    var components = DateComponents()
                    components.year = state.displayedYear
                    components.month = month
                    components.day = 1
                    
                    if let date = Calendar.current.date(from: components) {
                        months.append(date)
                    }
                }
                
                state.months = months
                return .none
                
            case .nextYear:
                state.displayedYear += 1
                
                // 다음 년도의 12개월 생성
                var months = [Date]()
                for month in 1...12 {
                    var components = DateComponents()
                    components.year = state.displayedYear
                    components.month = month
                    components.day = 1
                    
                    if let date = Calendar.current.date(from: components) {
                        months.append(date)
                    }
                }
                
                state.months = months
                return .none
            }
        }
    }
}
