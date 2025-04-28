//
//  CalendarDayView.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import SwiftUI
import Utils
import Domain

struct CalendarDayView: View {
    let date: Date?
    let events: [Event]
    let isSelected: Bool
    let isToday: Bool
    let onTap: (Date) -> Void
    
    var calendar = Calendar.current
    
    var body: some View {
        if let date = date {
            Button(action: {
                onTap(date)
            }) {
                VStack(spacing: 2) {
                    Text(DateHelpers.dayOfMonthString(from: date))
                        .font(.system(size: 16, weight: isToday ? .bold : .regular))
                        .foregroundColor(dayTextColor)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                    
                    if !events.isEmpty {
                        VStack(spacing: 1) {
                            // 최대 3개 이벤트만 표시
                            ForEach(events.prefix(3)) { event in
                                EventDotView(color: event.color.color)
                            }
                            
                            // 더 많은 이벤트가 있다면 "+" 표시
                            if events.count > 3 {
                                Text("+\(events.count - 3)")
                                    .font(.system(size: 8))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    
                    Spacer()
                }
                .frame(height: 60)
                .background(cellBackground)
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            // 비어있는 날짜 셀
            Rectangle()
                .fill(Color.clear)
                .frame(height: 60)
        }
    }
    
    private var dayTextColor: Color {
        if isSelected {
            return .white
        } else if isToday {
            return .blue
        } else {
            // 주말인 경우 색상 변경
            let weekday = calendar.component(.weekday, from: date!)
            if weekday == 1 {  // 일요일
                return .red
            } else if weekday == 7 {  // 토요일
                return .blue
            } else {
                return .primary
            }
        }
    }
    
    private var cellBackground: some View {
        Group {
            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 32, height: 32)
                    .padding(.top, -4)
                    .opacity(0.9)
            } else {
                Color.clear
            }
        }
    }
}

struct EventDotView: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(color)
            .frame(height: 5)
            .padding(.horizontal, 4)
    }
}
