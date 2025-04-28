//
//  EventListView.swift
//  Present
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import SwiftUI
import Domain
import CoreLocation

struct EventListView: View {
    let events: [Event]
    let onEventTapped: (Event) -> Void
    
    var body: some View {
        if events.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 48))
                    .foregroundColor(.gray.opacity(0.7))
                
                Text("이벤트 없음")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(groupedEvents.keys.sorted(), id: \.self) { time in
                    Section(header: Text(time)) {
                        ForEach(groupedEvents[time] ?? []) { event in
                            EventRowView(event: event)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    onEventTapped(event)
                                }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    // 시간대별로 이벤트 그룹화
    private var groupedEvents: [String: [Event]] {
        let allDayEvents = events.filter { $0.isAllDay }
        let timeEvents = events.filter { !$0.isAllDay }
        
        var result = [String: [Event]]()
        
        if !allDayEvents.isEmpty {
            result["종일"] = allDayEvents
        }
        
        // 시간별로 그룹화
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        
        for event in timeEvents {
            let timeKey = formatter.string(from: event.startDate)
            var eventsForTime = result[timeKey] ?? []
            eventsForTime.append(event)
            result[timeKey] = eventsForTime
        }
        
        return result
    }
}

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 12) {
            Rectangle()
                .fill(event.color.color)
                .frame(width: 4)
                .cornerRadius(2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                
                if !event.isAllDay {
                    Text(event.displayTime)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if let location = event.location, !location.isEmpty {
                    Text(location)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text(event.calendar.rawValue)
                .font(.caption2)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(event.calendar.color.opacity(0.2))
                .cornerRadius(4)
        }
        .padding(.vertical, 4)
    }
}

