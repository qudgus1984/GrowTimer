//
//  LaunchScreenView.swift
//  WorkCheckListManagementPresent
//
//  Created by Den on 4/19/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import ThirdPartyLibrary
import Utility

public class LaunchScreenViewController: BaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = ThemaManager.shared.lightColor
        appearence.shadowColor = .clear


        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        UserDefaultManager.timerRunning = false
        UserDefaultManager.bright = UIScreen.main.brightness
        
        if UserDefaultManager.start {
            if UserDefaultManager.engagedTime == 0 {
                self.transition(TimeSettingViewController(reactor: TimeSettingReactor(delegate: nil)), transitionStyle: .rootViewControllerChange)

            } else {
                self.transition(HomeViewController(reactor: HomeReactor()), transitionStyle: .rootViewControllerChange)
            }
        } else {
            self.transition(PageNationViewController(), transitionStyle: .rootViewControllerChange)
            
        }
    }
}
