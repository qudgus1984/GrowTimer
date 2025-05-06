//
//  ThemaSettingView.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import SnapKit

final class ThemaSettingView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = ThemaManager.shared.lightColor
        view.register(BaseDesignSettingTableViewCell.self, forCellReuseIdentifier: "BaseDesignSettingTableViewCell")
        return view
    }()
    
    let alertView: AlertView = {
        let view = AlertView(title: "테마를 구매하시겠습니까?", subtitle: "테마 가격은 1000코인 입니다.", okButtonTitle: "확인", cancelButtonTitle: "취소")
        view.basePopupView.backgroundColor = ThemaManager.shared.calendarChoiceColor
        view.titleLabel.font = FontManager.shared.font16
        view.subtitleLabel.font = FontManager.shared.font12
        view.okButtonLabel.font = FontManager.shared.font16
        view.cancelButtonLabel.font = FontManager.shared.font16
        view.isHidden = true
        return view
    }()
    
    override func configureUI() {
        [tableView, alertView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
 
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        alertView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(166)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
