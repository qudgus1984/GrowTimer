//
//  FinishPopupView.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem

import SnapKit

final class FinishPopupView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    //MARK: UI 설정
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()
    
    let settingView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.lightColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = FontManager.shared.font16
        label.textAlignment = .center
        label.text =
"""
지정한 시간을 완료하셨네요 :)
의지력이 강한 당신 칭찬해!
더 열심히 하다보면 당신의 사과나무가 변할지도...?
+ \(UserDefaults.standard.integer(forKey: "engagedTime")/60)분!
"""

        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ThemaManager.shared.mainColor
        button.setTitle("확인", for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func configureUI() {
        [backView, settingView, textLabel, okButton].forEach {
        self.addSubview($0)
        }
    }

    
    //MARK: 제약 사항
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        settingView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.center.equalTo(backView)
        }
        
        textLabel.snp.makeConstraints { make in
            make.edges.equalTo(settingView).inset(UIEdgeInsets(top: 16, left: 16, bottom: 60, right: 16))
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalTo(settingView).inset(16)
        }
    }
}
