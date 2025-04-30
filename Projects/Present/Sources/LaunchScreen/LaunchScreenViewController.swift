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

public class LaunchScreenViewController: BaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GT.Color.huntBeach
        
        self.navigationController?.pushViewController(PageNationViewController(), animated: true)
    }
}
