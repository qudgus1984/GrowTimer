//
//  ThemaSettingReactor.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import Foundation

import Utility
import ThirdPartyLibrary
import DesignSystem
import Domain

import ReactorKit
import RxSwift

// MARK: - Reactor
final class ThemaSettingReactor: Reactor {
    
    @Injected private var coinUseCase: CoinUseCaseInterface
    @Injected private var themaUseCase: ThemaUseCaseInterface
    
    var initialState: State = State()

    // 액션 정의
    enum Action {
        case viewDidLoadTrigger
        case cellTappedWithModel(IndexPath, ThemaEntity)
        case okButtonTapped(IndexPath, ThemaEntity)


        case cancelButtonTapped
    }
    
    // 변이 정의
    enum Mutation {
        case showToast(String)
        case showAlert(Bool)

        case clearToastMessage
        case themaTable([ThemaEntity])
        
        case navigateToRoot(Bool)
    }
    
    // 상태 정의
    struct State {
        var toastMessage: String?
        var shouldNavigateToRoot: Bool = false
        
        var alertViewIsHidden: Bool = false

        var fontSettingList: [String] = Thema.allCases.map(\.rawValue)
        var themaTable: [ThemaEntity] = []
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .cellTappedWithModel(let indexPath, let themaEntity):
            // 타이머 실행 중인지 확인
            if UserDefaultManager.timerRunning {
                return .concat([
                    .just(.showToast("타이머가 가는 동안은 테마를 변경할 수 없어요!")),
                    .just(.clearToastMessage).delay(.seconds(3), scheduler: MainScheduler.instance)
                ])
            } else {
                if themaEntity.purchase {
                    ThemaManager.shared.themaUpdate(themaNum: indexPath.row)

                    return .concat([
                        .just(.navigateToRoot(true)),
                        .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                    ])
                } else {
                    let totalCoin = coinUseCase.excuteTotalCoin()
                    
                    if totalCoin < 1000 {
                        return .just(.showToast("\(themaEntity.themaName)을 구입하기 위해서는 1000코인이 필요해요."))
                    } else {
                        return .just(.showAlert(true))
                    }
                }
            }
        case .viewDidLoadTrigger:
            let themaTable = themaUseCase.excuteFetchThemaTable()
            return .just(.themaTable(themaTable))
        case .okButtonTapped(let indexPath, let themaEntity):
            coinUseCase.excuteCreateCoin(CoinEntity(id: UUID(), getCoin: 0, spendCoin: 1000, status: 400 + indexPath.row, now: .now))
            themaUseCase.excuteThemaBuy(id: themaEntity.id)
            UserDefaultManager.thema = indexPath.row
            ThemaManager.shared.themaUpdate(themaNum: indexPath.row)
            return .concat([
                .just(.navigateToRoot(true)),
                .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
            ])
            
        case .cancelButtonTapped:
            return .just(.showAlert(false))
        }
    }
    
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .showToast(let message):
            newState.toastMessage = message

        case .navigateToRoot(let navigate):
            UserDefaultManager.stopCount = 3
            newState.shouldNavigateToRoot = navigate
        case .clearToastMessage:
            newState.toastMessage = nil
        case .themaTable(let themaTable):
            newState.themaTable = themaTable
        case .showAlert(let bool):
            newState.alertViewIsHidden = bool
        }
        
        return newState
    }
}
