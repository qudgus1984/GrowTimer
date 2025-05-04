//
//  UserMapper.swift
//  Data
//
//  Created by Den on 5/4/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation
import Domain

// MARK: - Mapper 클래스들
final class UserMapper {
    static func toEntity(_ dto: UserDTO) -> UserEntity {
        return UserEntity(
            id: dto.id,
            startTime: dto.startTime,
            finishTime: dto.finishTime,
            settingTime: Int(dto.settingTime),
            success: dto.success,
            concentrateMode: dto.concentrateMode,
            stopButtonClicked: Int(dto.stopButtonClicked)
        )
    }
}

final class ThemaMapper {
    static func toEntity(_ dto: ThemaDTO) -> ThemaEntity {
        return ThemaEntity(
            id: dto.id,
            themaName: dto.themaName,
            purchase: dto.purchase
        )
    }
}

final class FontMapper {
    static func toEntity(_ dto: FontDTO) -> FontEntity {
        return FontEntity(
            id: dto.id,
            fontName: dto.fontName,
            purchase: dto.purchase
        )
    }
}

final class CoinMapper {
    static func toEntity(_ dto: CoinDTO) -> CoinEntity {
        return CoinEntity(
            id: dto.id,
            getCoin: Int(dto.getCoin),
            spendCoin: Int(dto.spendCoin),
            status: Int(dto.status),
            now: dto.now
        )
    }
}
