//
//  TimeSettingTableViewCell.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import Utility

import SnapKit

final class TimeSettingTableViewCell: BaseTVCell {
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font24
        label.textAlignment = .center
        return label
    }()
    
    override func configureUI() {
        [containView, explainLabel].forEach {
            contentView.addSubview($0)
        }
        
        self.backgroundColor = ThemaManager.shared.lightColor
    }
    
    override func configureLayout() {
        containView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(4)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension TimeSettingTableViewCell {
    func configure(with text: String) {
        explainLabel.text = text
    }
}
