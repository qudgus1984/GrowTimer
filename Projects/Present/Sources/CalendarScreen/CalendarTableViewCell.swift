//
//  CalendarTableViewCell.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import SnapKit
final class CalendarTableViewCell: BaseTVCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [containView, explainLabel].forEach {
            contentView.addSubview($0)
        }
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

extension CalendarTableViewCell {
    func configure(firstIndexText: String, secondIndexText: String, thirdIndexText: String, index: IndexPath) {
        
        switch index.row {
        case 0:
            explainLabel.text = firstIndexText
        case 1:
            explainLabel.text = secondIndexText
        case 2:
            explainLabel.text = thirdIndexText
        default:
            break
        }
    }
}
