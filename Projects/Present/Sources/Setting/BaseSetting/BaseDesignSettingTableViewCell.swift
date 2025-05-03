//
//  BaseDesignSettingTableViewCell.swift
//  Present
//
//  Created by Den on 5/3/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import Utility

import SnapKit

final class BaseDesignSettingTableViewCell: BaseTVCell {
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font24
        label.textAlignment = .center
        return label
    }()
    
    let lockImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemGray3
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        [containView, explainLabel, lockImageView].forEach {
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
        
        lockImageView.snp.makeConstraints { make in
            make.trailing.equalTo(containView.snp.trailing).offset(-20)
            make.centerY.equalTo(explainLabel)
            make.height.equalTo(containView.snp.height).multipliedBy(0.5)
            make.width.equalTo(lockImageView.snp.height)
        }
    }
}

extension BaseDesignSettingTableViewCell {
    func configureFont(with: String, indexPath: Int) {
        explainLabel.text = with
        
        switch indexPath {
        case 0:
            explainLabel.font = FontThema.UhBeeFont.Font24
        case 1:
            explainLabel.font = FontThema.GangwonFont.Font24
        case 2:
            explainLabel.font = FontThema.LeeSeoyunFont.Font24
        case 3:
            explainLabel.font = FontThema.SimKyunghaFont.Font24
        default:
            explainLabel.font = FontThema.UhBeeFont.Font24
        }
    }
    
    func configureThema(with: String) {
        explainLabel.text = with
    }
}
