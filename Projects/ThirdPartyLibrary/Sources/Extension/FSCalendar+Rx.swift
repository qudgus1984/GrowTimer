//
//  FSCalendar+Rx.swift
//  ThirdPartyLibrary
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import FSCalendar

public extension Reactive where Base: FSCalendar {
    public var didSelect: Observable<Date> {
        return delegate
            .methodInvoked(#selector(FSCalendarDelegate.calendar(_:didSelect:at:)))
            .map { parameters -> Date in
                return parameters[1] as! Date
            }
    }
    
    public var dataSource: DelegateProxy<FSCalendar, FSCalendarDataSource> {
        return RxFSCalendarDataSourceProxy.proxy(for: base)
    }
    
    public var delegate: DelegateProxy<FSCalendar, FSCalendarDelegate> {
        return RxFSCalendarDelegateProxy.proxy(for: base)
    }
}

public class RxFSCalendarDelegateProxy: DelegateProxy<FSCalendar, FSCalendarDelegate>, DelegateProxyType, FSCalendarDelegate {
    public static func registerKnownImplementations() {
        self.register { calendar -> RxFSCalendarDelegateProxy in
            RxFSCalendarDelegateProxy(parentObject: calendar, delegateProxy: self)
        }
    }
    
    public static func currentDelegate(for object: FSCalendar) -> FSCalendarDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: FSCalendarDelegate?, to object: FSCalendar) {
        object.delegate = delegate
    }
}

public class RxFSCalendarDataSourceProxy: DelegateProxy<FSCalendar, FSCalendarDataSource>, DelegateProxyType, FSCalendarDataSource {
    public static func registerKnownImplementations() {
        self.register { calendar -> RxFSCalendarDataSourceProxy in
            RxFSCalendarDataSourceProxy(parentObject: calendar, delegateProxy: self)
        }
    }
    
    public static func currentDelegate(for object: FSCalendar) -> FSCalendarDataSource? {
        return object.dataSource
    }
    
    public static func setCurrentDelegate(_ delegate: FSCalendarDataSource?, to object: FSCalendar) {
        object.dataSource = delegate
    }
}
