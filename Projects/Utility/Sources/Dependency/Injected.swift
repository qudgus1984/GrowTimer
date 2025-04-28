//
//  Injected.swift
//  Utility
//
//  Created by Den on 4/28/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T {
        DIContainer.resolve(type: T.self)
    }
    
    public init() { }
}
