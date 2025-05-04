//
//  UserEntity.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct UserEntity {
    public var id: UUID
    public var startTime: Date
    public var finishTime: Date?
    public var settingTime: Int
    public var success: Bool
    public var concentrateMode: Bool
    public var stopButtonClicked: Int
    
    public init(id: UUID, startTime: Date, finishTime: Date? = nil, settingTime: Int, success: Bool, concentrateMode: Bool, stopButtonClicked: Int) {
        self.id = id
        self.startTime = startTime
        self.finishTime = finishTime
        self.settingTime = settingTime
        self.success = success
        self.concentrateMode = concentrateMode
        self.stopButtonClicked = stopButtonClicked
    }
}
