//
//  Project.swift
//  Config
//
//  Created by Den on 4/18/25.
//

import UIKit
import SwiftUI
import Present

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        let contentView = CalendarViewFactory.makeCalendarView()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        window.backgroundColor = .white
        self.window = window
        window.makeKeyAndVisible()
    }
}
