//
//  CalendarView.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

// Present 모듈에 추가
import SwiftUI
import ComposableArchitecture
import Domain
import Utils

public struct CalendarViewFactory {
    public static func makeCalendarView() -> some View {
        let store = Store(
            initialState: CalendarFeature.State(
                calendarEntity: CalendarEntity(
                    events: sampleEvents,
                    selectedDate: Date(),
                    viewMode: .month
                )
            )
        ) {
            CalendarFeature()
                ._printChanges()
        }
        
        return CalendarView(store: store)
    }
    
    // 샘플 이벤트 코드는 여기로 옮김
    private static let sampleEvents: [Event] = {
        let calendar = Calendar.current
        let today = Date()
        
        // 오늘 시작하는 이벤트들
        let todayStart = calendar.startOfDay(for: today)
        let meeting = Event(
            title: "팀 미팅",
            startDate: calendar.date(byAdding: .hour, value: 10, to: todayStart)!,
            endDate: calendar.date(byAdding: .hour, value: 11, to: todayStart)!,
            notes: "주간 업무 계획 논의",
            location: "회의실 A",
            color: .blue,
            calendar: .work
        )
        
        let lunch = Event(
            title: "점심 약속",
            startDate: calendar.date(byAdding: .hour, value: 12, to: todayStart)!,
            endDate: calendar.date(byAdding: .hour, value: 13, to: todayStart)!,
            location: "레스토랑",
            color: .orange,
            calendar: .personal
        )
        
        // 내일 이벤트
        let tomorrowStart = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let workout = Event(
            title: "운동",
            startDate: calendar.date(byAdding: .hour, value: 7, to: tomorrowStart)!,
            endDate: calendar.date(byAdding: .hour, value: 8, to: tomorrowStart)!,
            color: .green,
            calendar: .personal
        )
        
        // 어제 이벤트
        let yesterdayStart = calendar.date(byAdding: .day, value: -1, to: todayStart)!
        let dentist = Event(
            title: "치과 예약",
            startDate: calendar.date(byAdding: .hour, value: 15, to: yesterdayStart)!,
            endDate: calendar.date(byAdding: .hour, value: 16, to: yesterdayStart)!,
            location: "치과의원",
            color: .red,
            calendar: .personal
        )
        
        // 종일 이벤트
        let holiday = Event(
            title: "공휴일",
            startDate: calendar.date(byAdding: .day, value: 3, to: todayStart)!,
            endDate: calendar.date(byAdding: .day, value: 3, to: todayStart)!,
            color: .purple,
            isAllDay: true,
            calendar: .default
        )
        
        let birthday = Event(
            title: "생일",
            startDate: calendar.date(byAdding: .day, value: 5, to: todayStart)!,
            endDate: calendar.date(byAdding: .day, value: 5, to: todayStart)!,
            notes: "케이크 주문하기",
            color: .pink,
            isAllDay: true,
            calendar: .family
        )
        
        return [meeting, lunch, workout, dentist, holiday, birthday]
    }()
}

struct CalendarView: View {
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack(spacing: 0) {
                    // 캘린더 헤더
                    calendarHeader(viewStore: viewStore)
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                    
                    // 뷰 모드 선택
                    viewModeSelector(viewStore: viewStore)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    
                    // 캘린더 내용
                    calendarContent(viewStore: viewStore)
                }
                .navigationTitle("캘린더")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewStore.send(.todayButtonTapped)
                        }) {
                            Text("오늘")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewStore.send(.createEventButtonTapped)
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(
                    store: store.scope(
                        state: \.$eventCreation,
                        action: { .eventCreation($0) }
                    )
                ) { eventCreationStore in
                    NavigationStack {
                        EventCreationView(store: eventCreationStore)
                    }
                }
                .sheet(
                    store: store.scope(
                        state: \.$eventDetail,
                        action: { .eventDetail($0) }
                    )
                ) { eventDetailStore in
                    NavigationStack {
                        EventDetailView(store: eventDetailStore)
                    }
                }
                .sheet(
                    store: store.scope(
                        state: \.$monthSelection,
                        action: { .monthSelection($0) }
                    )
                ) { monthSelectionStore in
                    MonthSelectionView(store: monthSelectionStore)
                }
            }
        }
    }
    
    private func calendarHeader(viewStore: ViewStoreOf<CalendarFeature>) -> some View {
        HStack {
            Button(action: {
                viewStore.send(.calendarHeaderTapped)
            }) {
                HStack {
                    Text(viewStore.currentMonthString)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    viewStore.send(.previousMonth)
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Button(action: {
                    viewStore.send(.nextMonth)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
        }
    }
    
    private func viewModeSelector(viewStore: ViewStoreOf<CalendarFeature>) -> some View {
        HStack {
            ForEach(CalendarViewMode.allCases) { viewMode in
                Button(action: {
                    viewStore.send(.viewModeChanged(viewMode))
                }) {
                    Text(viewMode.displayName)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            viewStore.calendarEntity.viewMode == viewMode ?
                                Color.blue.opacity(0.1) : Color.clear
                        )
                        .cornerRadius(8)
                        .foregroundColor(
                            viewStore.calendarEntity.viewMode == viewMode ?
                                .blue : .primary
                        )
                }
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func calendarContent(viewStore: ViewStoreOf<CalendarFeature>) -> some View {
        switch viewStore.calendarEntity.viewMode {
        case .month:
            VStack {
                let daysInMonth = DateHelpers.generateDaysInMonthGrid(for: viewStore.calendarEntity.selectedDate)
                
                // 캘린더 그리드
                CalendarGridView(
                    daysInMonth: daysInMonth,
                    events: viewStore.calendarEntity.events,
                    selectedDate: viewStore.calendarEntity.selectedDate,
                    onDateSelected: { date in
                        viewStore.send(.dateSelected(date))
                    }
                )
                .padding(.horizontal, 4)
                
                Divider()
                
                // 선택된 날짜의 이벤트 목록
                let selectedDateEvents = viewStore.calendarEntity.eventsForDate(viewStore.calendarEntity.selectedDate)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(DateHelpers.monthYearString(from: viewStore.calendarEntity.selectedDate) + " " + DateHelpers.dayOfMonthString(from: viewStore.calendarEntity.selectedDate) + "일")
                            .font(.headline)
                        
                        Text(DateHelpers.weekdayString(from: viewStore.calendarEntity.selectedDate))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    EventListView(
                        events: selectedDateEvents,
                        onEventTapped: { event in
                            viewStore.send(.eventTapped(event))
                        }
                    )
                }
                
                Spacer()
            }
            
        case .day:
            Text("일간 뷰 - 개발 중")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .week:
            Text("주간 뷰 - 개발 중")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .year:
            Text("연간 뷰 - 개발 중")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
