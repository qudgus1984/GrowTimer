//
//  SettingView.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import SnapKit

final class SettingView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = ThemaManager.shared.lightColor
        view.register(TimeSettingTableViewCell.self, forCellReuseIdentifier: TimeSettingTableViewCell.reuseIdentifier)
        return view
    }()
    

    override func configureUI() {
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
 
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
}
