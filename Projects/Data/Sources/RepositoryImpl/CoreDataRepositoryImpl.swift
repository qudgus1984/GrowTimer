//
//  CoreDataRepositoryImpl.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//



// MARK: - Repository 구현
import Foundation
import CoreData
import Domain

// MARK: - Repository 구현
public final class CoreDataRepositoryImpl: CoreDataRepository {
    // 각 모델별 저장소
    private let userStorage: CoreDataStorage
    private let themaStorage: CoreDataStorage
    private let fontStorage: CoreDataStorage
    private let coinStorage: CoreDataStorage
    
    public init(userStorage: CoreDataStorage = CoreDataStorage.userStorage,
         themaStorage: CoreDataStorage = CoreDataStorage.themaStorage,
         fontStorage: CoreDataStorage = CoreDataStorage.fontStorage,
         coinStorage: CoreDataStorage = CoreDataStorage.coinStorage) {
        self.userStorage = userStorage
        self.themaStorage = themaStorage
        self.fontStorage = fontStorage
        self.coinStorage = coinStorage
    }
    
    // MARK: - User 관련 메서드
    public func fetchUser() -> [UserEntity] {
        let sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: true)]
        let dtos = userStorage.fetch(UserDTO.self, sortDescriptors: sortDescriptors)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func addUser(settingTime: Int) {
        let dto = UserDTO.create(in: userStorage.mainContext, settingTime: Int32(settingTime))
        userStorage.save()
    }
    
    public func updateUserState(id: UUID, success: Bool) {
        guard let dto = userStorage.fetchById(UserDTO.self, id: id) else { return }
        dto.success = success
        dto.finishTime = Date()
        userStorage.save()
    }
    
    // MARK: - Thema 관련 메서드
    public func fetchThemaTable() -> [ThemaEntity] {
        let dtos = themaStorage.fetch(ThemaDTO.self)
        return dtos.map { ThemaMapper.toEntity($0) }
    }
    
    public func firstStartThema(themaName: String, purchase: Bool) {
        let _ = ThemaDTO.create(in: themaStorage.mainContext, themaName: themaName, purchase: purchase)
        themaStorage.save()
    }
    
    public func themaBuy(id: UUID) {
        guard let dto = themaStorage.fetchById(ThemaDTO.self, id: id) else { return }
        dto.purchase = true
        themaStorage.save()
    }
    
    // MARK: - Font 관련 메서드
    public func fetchFontTable() -> [FontEntity] {
        let dtos = fontStorage.fetch(FontDTO.self)
        return dtos.map { FontMapper.toEntity($0) }
    }
    
    public func firstStartFont(fontName: String, purchase: Bool) {
        let _ = FontDTO.create(in: fontStorage.mainContext, fontName: fontName, purchase: purchase)
        fontStorage.save()
    }
    
    public func fontBuy(id: UUID) {
        guard let dto = fontStorage.fetchById(FontDTO.self, id: id) else { return }
        dto.purchase = true
        fontStorage.save()
    }
    
    // MARK: - Coin 관련 메서드
    public func fetchCoinTable() -> [CoinEntity] {
        let dtos = coinStorage.fetch(CoinDTO.self)
        return dtos.map { CoinMapper.toEntity($0) }
    }
    
    public func addCoin(getCoin: Int, spendCoin: Int, status: Int) {
        let _ = CoinDTO.create(in: coinStorage.mainContext, getCoin: Int32(getCoin), spendCoin: Int32(spendCoin), status: Int16(status))
        coinStorage.save()
    }
    
    public func totalCoin() -> Int {
        let dtos = coinStorage.fetch(CoinDTO.self)
        return Int(dtos.reduce(0) { $0 + $1.getCoin - $1.spendCoin })
    }
    
    public func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 1
        case 60 * 30:
            return 3
        case 60 * 60:
            return 10
        case 60 * 120:
            return 30
        case 60 * 240:
            return 80
        case 60 * 480:
            return 200
        default:
            return 0
        }
    }
    
    // MARK: - 필터 관련 메서드
    public func todayFilter() -> [UserEntity] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@",
                                   startOfDay as NSDate,
                                   endOfDay as NSDate)
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func dayFilter(date: Date) -> [UserEntity] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@",
                                   startOfDay as NSDate,
                                   endOfDay as NSDate)
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func twoHourTimeFilter(date: Date) -> [UserEntity] {
        let twoHoursLater = date.addingTimeInterval(3600 * 2)
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@",
                                   date as NSDate,
                                   twoHoursLater as NSDate)
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func dayTotalTimeFilter(date: Date) -> Int {
        let items = dayFilter(date: date).filter { $0.success }
        
        if items.isEmpty {
            return 0
        } else {
            let totalTime = items.reduce(0) { $0 + $1.settingTime }
            return totalTime / 60
        }
    }
    
    public func dayTotalTimeLineFilter(date: Date) -> Int {
        let items = dayFilter(date: date).filter { $0.success }
        
        if items.isEmpty {
            return 0
        } else {
            return items.reduce(0) { $0 + $1.settingTime }
        }
    }
    
    public func monthTotalTimeFilter(date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@ AND success == %@",
                                   startOfMonth as NSDate,
                                   nextMonth as NSDate,
                                   NSNumber(value: true))
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        let totalTime = dtos.reduce(0) { $0 + $1.settingTime }
        return Int(totalTime / 60)
    }
    
    public func monthCount(date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@ AND success == %@",
                                   startOfMonth as NSDate,
                                   nextMonth as NSDate,
                                   NSNumber(value: true))
        
        return userStorage.count(UserDTO.self, predicate: predicate)
    }
    
    public func successfulRate() -> Int {
        let totalCount = userStorage.count(UserDTO.self)
        if totalCount == 0 {
            return 0
        }
        
        let successPredicate = NSPredicate(format: "success == %@", NSNumber(value: true))
        let successCount = userStorage.count(UserDTO.self, predicate: successPredicate)
        
        let successRate = Double(successCount) / Double(totalCount) * 100
        return Int(successRate)
    }
    
    public func yesterdayFilter() -> [UserEntity] {
        let calendar = Calendar.current
        let startOfYesterday = calendar.startOfDay(for: Date().addingTimeInterval(-86400))
        let endOfYesterday = calendar.startOfDay(for: Date())
        
        let predicate = NSPredicate(format: "startTime >= %@ AND startTime < %@",
                                   startOfYesterday as NSDate,
                                   endOfYesterday as NSDate)
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func todayTotalStudyTime() -> [UserEntity] {
        let successPredicate = NSPredicate(format: "success == %@", NSNumber(value: true))
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            successPredicate,
            NSPredicate(format: "startTime >= %@ AND startTime < %@", startOfDay as NSDate, endOfDay as NSDate)
        ])
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
    
    public func dayTotalStudyTime(date: Date) -> [UserEntity] {
        let successPredicate = NSPredicate(format: "success == %@", NSNumber(value: true))
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            successPredicate,
            NSPredicate(format: "startTime >= %@ AND startTime < %@", startOfDay as NSDate, endOfDay as NSDate)
        ])
        
        let dtos = userStorage.fetch(UserDTO.self, predicate: predicate)
        return dtos.map { UserMapper.toEntity($0) }
    }
}
