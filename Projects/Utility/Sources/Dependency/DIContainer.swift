//
//  DIContainer.swift
//  Utility
//
//  Created by Den on 4/28/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public enum DIContainer {
    private static var storage = [String: Any]()
    
    public static func register<T>(_ value: T, type: T.Type) {
        storage["\(type)"] = value
    }
    
    @discardableResult
    public static func resolve<T>(type: T.Type) -> T {
        guard let value = storage["\(type)"] as? T else {
            fatalError("등록되지 않은 객체 호출: \(type)")
        }
        return value
    }
}
