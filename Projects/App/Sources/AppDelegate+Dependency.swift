//
//  AppDelegate+Dependency.swift
//  App
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import FeatureInterface
import FeatureImplement
import Utility
import DesignSystem
import Data
import Domain

extension AppDelegate {
    func registerDependencies() {
        DIContainer.register(FeatureProviderImplement(), type: FeatureProvider.self)
        FontRegistration.registerFonts()
        DIContainer.register(CoreDataRepositoryImpl(userStorage: .userStorage, themaStorage: .themaStorage, fontStorage: .fontStorage, coinStorage: .coinStorage), type: CoreDataRepository.self)
        DIContainer.register(CoreDataUseCase(), type: CoreDataUseCaseInterface.self)
        DIContainer.register(CoinRepositoryImpl(coinStorage: .coinStorage), type: CoinRepository.self)
        DIContainer.register(CoinUseCase(), type: CoinUseCaseInterface.self)
        DIContainer.register(UserRepositoryImpl(userStorage: .userStorage), type: UserRepository.self)
        DIContainer.register(UserUseCase(), type: UserUseCaseInterface.self)
        DIContainer.register(FontRepositoryImpl(fontStorage: .fontStorage), type: FontRepository.self)
        DIContainer.register(FontUseCase(), type: FontUseCaseInterface.self)
        
        DIContainer.register(ThemaRepositoryImpl(themaStorage: .themaStorage), type: ThemaRepository.self)
        DIContainer.register(ThemaUseCase(), type: ThemaUseCaseInterface.self)
    }
}
