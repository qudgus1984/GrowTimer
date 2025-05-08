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
    @NSManaged public var settingTime: Int32
    @NSManaged public var success: Bool
    @NSManaged public var concentrateMode: Bool
    @NSManaged public var stopButtonClicked: Int16
    
    // Realm의 ObjectId 대신 UUID 사용
    @NSManaged public var id: UUID
    
    @discardableResult
    static func create(in context: NSManagedObjectContext,
                      settingTime: Int32) -> UserDTO {
        
        let entity = NSEntityDescription.entity(forEntityName: "UserDTO", in: context)
        
        guard let entity = entity else {
            fatalError("Failed to find entity description for UserDTO")
        }
        
        let dto = UserDTO(context: context)
        dto.id = UUID()
        dto.startTime = Date()
        dto.success = false
        dto.concentrateMode = false
        dto.settingTime = settingTime
        dto.stopButtonClicked = 0
        
        print("Created UserDTO with settingTime: \(settingTime), id: \(dto.id)")

        return dto
    }
}

extension UserDTO {
    public var toDomain: UserEntity {
        return UserEntity(id: id, startTime: startTime, finishTime: finishTime, settingTime: Int(settingTime), success: success, concentrateMode: concentrateMode, stopButtonClicked: Int(stopButtonClicked))
    }
}
