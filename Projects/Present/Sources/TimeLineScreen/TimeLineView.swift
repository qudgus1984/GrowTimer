//
//  TimeLineView.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import SnapKit

final class TimeLineView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = ThemaManager.shared.lightColor
        view.register(TimeLineTableViewCell.self, forCellReuseIdentifier: TimeLineTableViewCell.reuseIdentifier)
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

