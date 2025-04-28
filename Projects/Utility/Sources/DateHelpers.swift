//
//  DateHelpers.swift
//  Utils
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct DateHelpers {
    public static let calendar = Calendar.current
    
    public static func startOfMonth(for date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    public static func endOfMonth(for date: Date) -> Date {
        let start = startOfMonth(for: date)
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: start)!
    }
    
    public static func daysInMonth(for date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    public static func firstWeekdayOfMonth(for date: Date) -> Int {
        let startOfMonth = self.startOfMonth(for: date)
        return calendar.component(.weekday, from: startOfMonth)
    }
    
    public static func generateDaysInMonth(for date: Date) -> [Date] {
        let startOfMonth = self.startOfMonth(for: date)
        let daysInMonth = self.daysInMonth(for: date)
        
        var days = [Date]()
        
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    public static func generateDaysInMonthGrid(for date: Date) -> [[Date?]] {
        let startOfMonth = self.startOfMonth(for: date)
        let daysInMonth = self.daysInMonth(for: date)
        let firstWeekday = self.firstWeekdayOfMonth(for: date) - 1 // 0 based index
        
        var days = [Date?](repeating: nil, count: firstWeekday)
        
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        
        // 마지막 주의 남은 부분을 nil로 채워서 그리드를 완성
        let remainingDays = 42 - days.count // 6주 x 7일 = 42 (표준 캘린더 그리드)
        if remainingDays > 0 {
            days.append(contentsOf: [Date?](repeating: nil, count: remainingDays))
        }
        
        // 7일씩 나누어 2차원 배열 생성
        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<min($0 + 7, days.count)])
        }
    }
    
    public static func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    public static func dayOfMonthString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    public static func weekdayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    public static func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
