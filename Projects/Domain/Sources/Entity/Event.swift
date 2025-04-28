//
//  Event.swift
//  Domain
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import SwiftUI

public struct Event: Identifiable, Equatable, Codable {
    public var id: UUID
    public var title: String
    public var startDate: Date
    public var endDate: Date
    public var notes: String?
    public var location: String?
    public var color: EventColor
    public var isAllDay: Bool
    public var calendar: CalendarType
    
    public init(
        id: UUID = UUID(),
        title: String,
        startDate: Date,
        endDate: Date,
        notes: String? = nil,
        location: String? = nil,
        color: EventColor = .blue,
        isAllDay: Bool = false,
        calendar: CalendarType = .default
    ) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.location = location
        self.color = color
        self.isAllDay = isAllDay
        self.calendar = calendar
    }
    
    public var displayTime: String {
        if isAllDay {
            return "종일"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }
    
    public var durationInMinutes: Int {
        return Int(endDate.timeIntervalSince(startDate) / 60)
    }
}

public enum EventColor: String, CaseIterable, Identifiable, Codable {
    case red, orange, yellow, green, blue, purple, pink, gray
    
    public var id: String { rawValue }
    
    public var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .pink: return .pink
        case .gray: return .gray
        }
    }
}

public enum CalendarType: String, CaseIterable, Identifiable, Codable {
    case `default` = "기본"
    case work = "업무"
    case personal = "개인"
    case family = "가족"
    
    public var id: String { rawValue }
    
    public var color: Color {
        switch self {
        case .default: return .blue
        case .work: return .green
        case .personal: return .purple
        case .family: return .orange
        }
    }
}

// Models/CalendarData.swift
import Foundation

public struct CalendarEntity: Equatable, Codable {
    public var events: [Event]
    public var selectedDate: Date
    public var viewMode: CalendarViewMode
    
    public init(
        events: [Event] = [],
        selectedDate: Date = Date(),
        viewMode: CalendarViewMode = .month
    ) {
        self.events = events
        self.selectedDate = selectedDate
        self.viewMode = viewMode
    }
    
    public func eventsForDate(_ date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { event in
            if event.isAllDay {
                return calendar.isDate(date, inSameDayAs: event.startDate)
            } else {
                // 이벤트의 시작일과 종료일 사이에 해당 날짜가 포함되어 있는지 확인
                let startOfDay = calendar.startOfDay(for: date)
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                
                return (event.startDate < endOfDay && event.endDate > startOfDay)
            }
        }
    }
}

public enum CalendarViewMode: String, CaseIterable, Identifiable, Codable {
    case day, week, month, year
    
    public var id: String { rawValue }
    
    public var displayName: String {
        switch self {
        case .day: return "일"
        case .week: return "주"
        case .month: return "월"
        case .year: return "년"
        }
    }
}
