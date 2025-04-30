//
//  SecondPageViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

final class SecondPageViewController: BaseViewController {

    private let mainview = PageView()

    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.explainLabel.text = "설정한 시간을 완료하지 않고 앱을 나가면 나무가 시들어요."
        mainview.imageView.image = .appletreeDie
    }

}
