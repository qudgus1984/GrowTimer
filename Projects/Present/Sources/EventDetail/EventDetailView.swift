//
//  EventDetailView.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain
import Utils

struct EventDetailView: View {
    let store: StoreOf<EventDetailFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                if viewStore.isEditing {
                    editView(viewStore: viewStore)
                } else {
                    detailView(viewStore: viewStore)
                }
            }
            .navigationTitle(viewStore.isEditing ? "이벤트 편집" : "이벤트 상세")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewStore.isEditing {
                        Button("저장") {
                            viewStore.send(.saveEvent(viewStore.event))
                        }
                    } else {
                        Button("편집") {
                            viewStore.send(.editButtonTapped)
                        }
                    }
                }
                
                if viewStore.isEditing {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            viewStore.send(.cancelEditing)
                        }
                    }
                }
            }
        }
    }
    
    private func detailView(viewStore: ViewStoreOf<EventDetailFeature>) -> some View {
        Group {
            Section {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(viewStore.event.color.color)
                        .frame(width: 12, height: 12)
                    
                    Text(viewStore.event.title)
                        .font(.headline)
                }
            }
            
            Section("시간") {
                if viewStore.event.isAllDay {
                    Text("종일")
                } else {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(viewStore.event.displayTime)
                    }
                    
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(.gray)
                        Text("\(viewStore.event.durationInMinutes)분")
                    }
                }
            }
            
            if let location = viewStore.event.location, !location.isEmpty {
                Section("위치") {
                    HStack {
                        Image(systemName: "mappin")
                            .foregroundColor(.gray)
                        Text(location)
                    }
                }
            }
            
            if let notes = viewStore.event.notes, !notes.isEmpty {
                Section("메모") {
                    Text(notes)
                }
            }
            
            Section("캘린더") {
                HStack {
                    Circle()
                        .fill(viewStore.event.calendar.color)
                        .frame(width: 12, height: 12)
                    Text(viewStore.event.calendar.rawValue)
                }
            }
            
            Section {
                Button(role: .destructive) {
                    viewStore.send(.deleteEvent)
                } label: {
                    HStack {
                        Spacer()
                        Text("삭제")
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func editView(viewStore: ViewStoreOf<EventDetailFeature>) -> some View {
        Group {
            Section {
                TextField("제목", text: Binding(
                    get: { viewStore.event.title },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.title, $0))) }
                ))
            }
            
            Section("시간") {
                Toggle("종일", isOn: Binding(
                    get: { viewStore.event.isAllDay },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.isAllDay, $0))) }
                ))
                
                DatePicker("시작", selection: Binding(
                    get: { viewStore.event.startDate },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.startDate, $0))) }
                ), displayedComponents: viewStore.event.isAllDay ? .date : [.date, .hourAndMinute])
                
                DatePicker("종료", selection: Binding(
                    get: { viewStore.event.endDate },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.endDate, $0))) }
                ), displayedComponents: viewStore.event.isAllDay ? .date : [.date, .hourAndMinute])
            }
            
            Section("세부 정보") {
                TextField("위치", text: Binding(
                    get: { viewStore.event.location ?? "" },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.location, $0.isEmpty ? nil : $0))) }
                ))
                
                TextField("메모", text: Binding(
                    get: { viewStore.event.notes ?? "" },
                    set: { viewStore.send(.updateEvent(viewStore.event.with(\.notes, $0.isEmpty ? nil : $0))) }
                ), axis: .vertical)
                    .lineLimit(5)
            }
            
            Section("색상") {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 8) {
                    ForEach(EventColor.allCases) { color in
                        Circle()
                            .fill(color.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                viewStore.event.color == color ?
                                    Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    : nil
                            )
                            .onTapGesture {
                                viewStore.send(.updateEvent(viewStore.event.with(\.color, color)))
                            }
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section("캘린더") {
                ForEach(CalendarType.allCases) { calendarType in
                    HStack {
                        Circle()
                            .fill(calendarType.color)
                            .frame(width: 12, height: 12)
                        
                        Text(calendarType.rawValue)
                        
                        Spacer()
                        
                        if viewStore.event.calendar == calendarType {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewStore.send(.updateEvent(viewStore.event.with(\.calendar, calendarType)))
                    }
                }
            }
        }
    }
}

// Features/EventCreation/EventCreationView.swift
import SwiftUI
import ComposableArchitecture

struct EventCreationView: View {
    let store: StoreOf<EventCreationFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    TextField("제목", text: Binding(
                        get: { viewStore.event.title },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.title, $0))) }
                    ))
                }
                
                Section("시간") {
                    Toggle("종일", isOn: Binding(
                        get: { viewStore.event.isAllDay },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.isAllDay, $0))) }
                    ))
                    
                    DatePicker("시작", selection: Binding(
                        get: { viewStore.event.startDate },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.startDate, $0))) }
                    ), displayedComponents: viewStore.event.isAllDay ? .date : [.date, .hourAndMinute])
                    
                    DatePicker("종료", selection: Binding(
                        get: { viewStore.event.endDate },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.endDate, $0))) }
                    ), displayedComponents: viewStore.event.isAllDay ? .date : [.date, .hourAndMinute])
                }
                
                Section("세부 정보") {
                    TextField("위치", text: Binding(
                        get: { viewStore.event.location ?? "" },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.location, $0.isEmpty ? nil : $0))) }
                    ))
                    
                    TextField("메모", text: Binding(
                        get: { viewStore.event.notes ?? "" },
                        set: { viewStore.send(.updateEvent(viewStore.event.with(\.notes, $0.isEmpty ? nil : $0))) }
                    ), axis: .vertical)
                        .lineLimit(5)
                }
                
                Section("색상") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 8) {
                        ForEach(EventColor.allCases) { color in
                            Circle()
                                .fill(color.color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    viewStore.event.color == color ?
                                        Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        : nil
                                )
                                .onTapGesture {
                                    viewStore.send(.updateEvent(viewStore.event.with(\.color, color)))
                                }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("캘린더") {
                    ForEach(CalendarType.allCases) { calendarType in
                        HStack {
                            Circle()
                                .fill(calendarType.color)
                                .frame(width: 12, height: 12)
                            
                            Text(calendarType.rawValue)
                            
                            Spacer()
                            
                            if viewStore.event.calendar == calendarType {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewStore.send(.updateEvent(viewStore.event.with(\.calendar, calendarType)))
                        }
                    }
                }
            }
            .navigationTitle("새 이벤트")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        viewStore.send(.cancelCreation)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("추가") {
                        viewStore.send(.saveEvent(viewStore.event))
                    }
                    .disabled(viewStore.event.title.isEmpty)
                }
            }
        }
    }
}

// Features/MonthSelection/MonthSelectionView.swift
import SwiftUI
import ComposableArchitecture

struct MonthSelectionView: View {
    let store: StoreOf<MonthSelectionFeature>
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                // 년도 선택
                HStack {
                    Button(action: {
                        viewStore.send(.previousYear)
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text("\(viewStore.displayedYear)년")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(.nextYear)
                    }) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                
                // 월 그리드
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewStore.months, id: \.self) { month in
                        Button(action: {
                            viewStore.send(.monthSelected(month))
                        }) {
                            let monthName = DateHelpers.monthYearString(from: month).dropLast(5)
                            let isSelected = Calendar.current.isDate(month, equalTo: viewStore.selectedDate, toGranularity: .month)
                            
                            Text(String(monthName))
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(isSelected ? .blue : .primary)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

// Model Helpers
extension Event {
    func with<T>(_ keyPath: WritableKeyPath<Event, T>, _ value: T) -> Event {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
