//
//  UserDTO.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import CoreData
import Domain

@objc(UserDTO)
public class UserDTO: NSManagedObject {
    @NSManaged public var startTime: Date
    @NSManaged public var finishTime: Date?
    @NSManaged public var settingTime: Int
    @NSManaged public var success: Bool
    @NSManaged public var concentrateMode: Bool
    @NSManaged public var stopButtonClicked: Int
    
    // Realm의 ObjectId 대신 UUID 사용
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      settingTime: Int) -> UserDTO {
        let dto = UserDTO(context: context)
        dto.id = UUID()
        dto.startTime = Date()
        dto.success = false
        dto.concentrateMode = false
        dto.settingTime = Int(settingTime)
        dto.stopButtonClicked = 0
        return dto
    }
}

extension UserDTO {
    public var toDomain: UserEntity {
        return UserEntity(id: id, startTime: startTime, finishTime: finishTime, settingTime: settingTime, success: success, concentrateMode: concentrateMode, stopButtonClicked: stopButtonClicked)
    }
}
