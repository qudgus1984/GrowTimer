//
//  CoreDataRepository.swift
//  Domain
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

public protocol CoreDataRepository {
    func fetchUser() -> [UserEntity]
    func addUser(settingTime: Int)
    func updateUserState(id: UUID, success: Bool)
    
    // Thema 관련
    func fetchThemaTable() -> [ThemaEntity]
    func firstStartThema(themaName: String, purchase: Bool)
    func themaBuy(id: UUID)
    
    // Font 관련
    func fetchFontTable() -> [FontEntity]
    func firstStartFont(fontName: String, purchase: Bool)
    func fontBuy(id: UUID)
    
    // Coin 관련
    func fetchCoinTable() -> [CoinEntity]
    func addCoin(getCoin: Int, spendCoin: Int, status: Int)
    func totalCoin() -> Int
    func coinCalculator() -> Int
    
    // 필터 관련
    func todayFilter() -> [UserEntity]
    func dayFilter(date: Date) -> [UserEntity]
    func twoHourTimeFilter(date: Date) -> [UserEntity]
    func dayTotalTimeFilter(date: Date) -> Int
    func dayTotalTimeLineFilter(date: Date) -> Int
    func monthTotalTimeFilter(date: Date) -> Int
    func monthCount(date: Date) -> Int
    func successfulRate() -> Int
    func yesterdayFilter() -> [UserEntity]
    func todayTotalStudyTime() -> [UserEntity]
    func dayTotalStudyTime(date: Date) -> [UserEntity]

}

protocol UserRepository {
    func fetchUser() -> [UserEntity]
    func addUser(settingTime: Int)
    func updateUserState(id: UUID, success: Bool)
    // User 관련 필터 메서드들...
}

protocol ThemaRepository {
    func fetchThemaTable() -> [ThemaEntity]
    func firstStartThema(themaName: String, purchase: Bool)
    func themaBuy(id: UUID)
}

protocol FontRepository {
    func fetchFontTable() -> [FontEntity]
    func firstStartFont(fontName: String, purchase: Bool)
    func fontBuy(id: UUID)
}
