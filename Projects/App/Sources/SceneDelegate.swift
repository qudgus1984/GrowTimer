//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import UIKit

import Utility
import FeatureInterface


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @Injected private var featureProvider: FeatureProvider

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: featureProvider.createLaunchScreen())

        window.rootViewController = navigationController
        window.backgroundColor = .white
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        if UserDefaultManager.timerRunning {

            UserDefaultManager.timerRunning = false
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let navigationController = UINavigationController(rootViewController: featureProvider.createResetPopupScreen())
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}
