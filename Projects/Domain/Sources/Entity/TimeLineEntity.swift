//
//  TimeLineEntity.swift
//  Domain
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public struct TimeLineEntity {
    public var dateToString: String
    public var explainItemInfo: String
    public var coinInfo: String
    public var imageNum: Int
    
    public init(dateToString: String, explainItemInfo: String, coinInfo: String, imageNum: Int) {
        self.dateToString = dateToString
        self.explainItemInfo = explainItemInfo
        self.coinInfo = coinInfo
        self.imageNum = imageNum
    }
}
