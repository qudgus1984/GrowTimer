//
//  CalendarFeature.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Utils
import Domain

@Reducer
struct CalendarFeature {
    struct State: Equatable {
        var calendarEntity: CalendarEntity
        @PresentationState var eventDetail: EventDetailFeature.State?
        @PresentationState var eventCreation: EventCreationFeature.State?
        @PresentationState var monthSelection: MonthSelectionFeature.State?
        
        init(calendarEntity: CalendarEntity = CalendarEntity()) {
            self.calendarEntity = calendarEntity
        }
        
        var currentMonthString: String {
            return DateHelpers.monthYearString(from: calendarEntity.selectedDate)
        }
    }
    
    enum Action {
        case dateSelected(Date)
        case viewModeChanged(CalendarViewMode)
        case previousMonth
        case nextMonth
        case todayButtonTapped
        case createEventButtonTapped
        case eventTapped(Event)
        case calendarHeaderTapped
        case saveEvent(Event)
        case deleteEvent(UUID)
        
        // 자식 리듀서 액션
        case eventDetail(PresentationAction<EventDetailFeature.Action>)
        case eventCreation(PresentationAction<EventCreationFeature.Action>)
        case monthSelection(PresentationAction<MonthSelectionFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .dateSelected(date):
                state.calendarEntity.selectedDate = date
                return .none
                
            case let .viewModeChanged(viewMode):
                state.calendarEntity.viewMode = viewMode
                return .none
                
            case .previousMonth:
                guard let newDate = Calendar.current.date(
                    byAdding: .month,
                    value: -1,
                    to: state.calendarEntity.selectedDate
                ) else { return .none }
                
                state.calendarEntity.selectedDate = newDate
                return .none
                
            case .nextMonth:
                guard let newDate = Calendar.current.date(
                    byAdding: .month,
                    value: 1,
                    to: state.calendarEntity.selectedDate
                ) else { return .none }
                
                state.calendarEntity.selectedDate = newDate
                return .none
                
            case .todayButtonTapped:
                state.calendarEntity.selectedDate = Date()
                return .none
                
            case .createEventButtonTapped:
                let startTime = Calendar.current.date(
                    bySettingHour: Calendar.current.component(.hour, from: Date()),
                    minute: 0,
                    second: 0,
                    of: state.calendarEntity.selectedDate
                ) ?? state.calendarEntity.selectedDate
                
                let endTime = Calendar.current.date(
                    byAdding: .hour,
                    value: 1,
                    to: startTime
                ) ?? Date(timeInterval: 3600, since: startTime)
                
                state.eventCreation = EventCreationFeature.State(
                    event: Event(
                        title: "",
                        startDate: startTime,
                        endDate: endTime
                    )
                )
                return .none
                
            case let .eventTapped(event):
                state.eventDetail = EventDetailFeature.State(event: event)
                return .none
                
            case .calendarHeaderTapped:
                state.monthSelection = MonthSelectionFeature.State(
                    selectedDate: state.calendarEntity.selectedDate
                )
                return .none
                
            case let .saveEvent(event):
                // 이벤트가 이미 있는지 확인
                if let index = state.calendarEntity.events.firstIndex(where: { $0.id == event.id }) {
                    state.calendarEntity.events[index] = event
                } else {
                    state.calendarEntity.events.append(event)
                }
                return .none
                
            case let .deleteEvent(id):
                state.calendarEntity.events.removeAll { $0.id == id }
                return .none
                
            case let .eventDetail(.presented(.saveEvent(event))):
                return .send(.saveEvent(event))
                
            case let .eventDetail(.presented(.deleteEvent)):
                guard let eventId = state.eventDetail?.event.id else { return .none }
                return .send(.deleteEvent(eventId))
                
            case .eventDetail(.dismiss):
                state.eventDetail = nil
                return .none
                
            case let .eventCreation(.presented(.saveEvent(event))):
                return .send(.saveEvent(event))
                
            case .eventCreation(.dismiss):
                state.eventCreation = nil
                return .none
                
            case let .monthSelection(.presented(.monthSelected(date))):
                state.calendarEntity.selectedDate = date
                state.monthSelection = nil
                return .none
                
            case .monthSelection(.dismiss):
                state.monthSelection = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$eventDetail, action: /Action.eventDetail) {
            EventDetailFeature()
        }
        .ifLet(\.$eventCreation, action: /Action.eventCreation) {
            EventCreationFeature()
        }
        .ifLet(\.$monthSelection, action: /Action.monthSelection) {
            MonthSelectionFeature()
        }
    }
}
