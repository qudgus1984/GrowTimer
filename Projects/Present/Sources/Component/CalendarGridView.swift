//
//  CalendarGridView.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import SwiftUI
import Domain

struct CalendarGridView: View {
    let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    let daysInMonth: [[Date?]]
    let events: [Event]
    let selectedDate: Date
    let onDateSelected: (Date) -> Void
    
    var calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 8) {
            // 요일 헤더
            HStack(spacing: 0) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(
                            day == "일" ? .red :
                            day == "토" ? .blue : .primary
                        )
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)
            
            // 날짜 그리드
            VStack(spacing: 1) {
                ForEach(daysInMonth.indices, id: \.self) { weekIndex in
                    HStack(spacing: 1) {
                        ForEach(0..<7) { dayIndex in
                            if weekIndex < daysInMonth.count && dayIndex < daysInMonth[weekIndex].count {
                                let date = daysInMonth[weekIndex][dayIndex]
                                
                                CalendarDayView(
                                    date: date,
                                    events: eventsForDate(date),
                                    isSelected: isDateSelected(date),
                                    isToday: isDateToday(date),
                                    onTap: onDateSelected
                                )
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func eventsForDate(_ date: Date?) -> [Event] {
        guard let date = date else { return [] }
        return events.filter { event in
            calendar.isDate(date, inSameDayAs: event.startDate)
        }
    }
    
    private func isDateSelected(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        return calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    private func isDateToday(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        return calendar.isDateInToday(date)
    }
}
