//
//  TimeLineTableViewCell.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//


import UIKit

import Utility
import DesignSystem
import Domain

import SnapKit

final class TimeLineTableViewCell: BaseTVCell {
    
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ThemaManager.shared.progressColor
        return view
    }()
    
    private let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font24
        label.text = "explainLabel"
        return label
    }()
    
    private let containExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font16
        label.text = "containExplainLabel"
        return label
    }()
    
    private let statusExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font16
        label.text = "containExplainLabel"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [explainLabel, containView, iconImageView, containExplainLabel, statusExplainLabel].forEach {
            contentView.addSubview($0)
        }
        
        self.backgroundColor = ThemaManager.shared.lightColor
    }
    
    override func configureLayout() {
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(60)
        }
        
        containView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(300)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containView)
            make.centerY.equalTo(containView)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        containExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.bottom.equalTo(containView.snp.bottom).offset(-8)
            make.trailing.equalTo(containView.snp.trailing).offset(-8)
            make.leading.equalTo(containView.snp.leading).offset(8)
        }
        
        statusExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(containView.snp.top).offset(8)
            make.height.equalTo(30)
            make.trailing.equalTo(containView.snp.trailing).offset(-8)
            make.leading.equalTo(containView.snp.leading).offset(8)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        
        containView.clipsToBounds = true
        containView.layer.cornerRadius = 10
    }
}

extension TimeLineTableViewCell {
    func configureTimeLine(item: TimeLineEntity) {
        containExplainLabel.text = item.coinInfo
        iconImageView.image = changeImage(saveTime: item.imageNum)
        statusExplainLabel.text = item.explainItemInfo
        explainLabel.text = item.dateToString
    }
    
    private func changeImage(saveTime: Int) -> UIImage {
        switch saveTime {
        case 0:
            return .seeds
        case 1...7199:
            return .sprout
        case 7200...14399:
            return .blossom
        case 14400...21599:
            return .apple
        case 21600...:
            return .appleTree
        default:
            return .seeds
        }
    }
}
