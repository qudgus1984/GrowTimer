//
//  FontSettingReactor.swift
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
final class FontSettingReactor: Reactor {
    
    @Injected private var coinUseCase: CoinUseCaseInterface
    @Injected private var fontUseCase: FontUseCaseInterface
    
    var initialState: State = State()

    // 액션 정의
    enum Action {
        case viewDidLoadTrigger
        case cellTappedWithModel(IndexPath, FontEntity)
        
        case okButtonTapped(IndexPath, FontEntity)
        case cancelButtonTapped
    }
    
    // 변이 정의
    enum Mutation {
        case showToast(String)
        case showAlert(Bool)

        case clearToastMessage
        case fontTable([FontEntity])

        case navigateToRoot(Bool)
    }
    
    // 상태 정의
    struct State {
        var toastMessage: String?
        var alertViewIsHidden: Bool = false

        var shouldNavigateToRoot: Bool = false
        var fontSettingList: [String] = FontThema.allCases.map(\.rawValue)
        var fontTable: [FontEntity] = []
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .cellTappedWithModel(let indexPath, let fontEntity):
            // 타이머 실행 중인지 확인
            if UserDefaultManager.timerRunning {
                return .concat([
                    .just(.showToast("타이머가 가는 동안은 폰트를 변경할 수 없어요!")),
                    .just(.clearToastMessage).delay(.seconds(3), scheduler: MainScheduler.instance)
                ])
            } else {
                if fontEntity.purchase {
                    FontManager.shared.fontUpdate(fontNum: indexPath.row)
                    
                    return .concat([
                        .just(.navigateToRoot(true)),
                        .just(.navigateToRoot(false)).delay(.milliseconds(100), scheduler: MainScheduler.instance)
                    ])
                } else {
                    let totalCoin = coinUseCase.excuteTotalCoin()
                    
                    if totalCoin < 300 {
                        return .just(.showToast("\(fontEntity.fontName)을 구입하기 위해서는  300코인이 필요해요."))
                    } else {
                        return .just(.showAlert(true))
                    }
                }
            }
        case .viewDidLoadTrigger:
            let fontTable = fontUseCase.excuteFetchFontTable()
            return .just(.fontTable(fontTable))
        case .okButtonTapped(let indexPath, let fontEntity):
            coinUseCase.excuteCreateCoin(CoinEntity(id: UUID(), getCoin: 0, spendCoin: 300, status: 100 + indexPath.row, now: .now))
            fontUseCase.excuteFontBuy(id: fontEntity.id)
            UserDefaultManager.font = indexPath.row
            FontManager.shared.fontUpdate(fontNum: indexPath.row)
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
        case .showAlert(let bool):
            newState.alertViewIsHidden = bool
        case .navigateToRoot(let navigate):
            UserDefaultManager.stopCount = 3
            newState.shouldNavigateToRoot = navigate
        case .clearToastMessage:
            newState.toastMessage = nil
        case .fontTable(let fontTable):
            newState.fontTable = fontTable
        }
        return newState
    }
}
