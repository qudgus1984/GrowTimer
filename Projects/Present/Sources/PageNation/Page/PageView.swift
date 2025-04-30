//
//  PageView.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import Utility

final class PageView: BaseView {

    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()

    private let explainLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = FontManager.shared.font36
        label.textColor = .white
        return label
    }()

    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = ThemaManager.shared.lightColor
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
    }
    

    override func configureUI() {
        [bgView, explainLabel, imageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(bgView.snp.height).multipliedBy(0.35)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(explainLabel.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(imageView.snp.width)
        }
    }
}

extension PageView {
    func configureFirstPage() {
        imageView.backgroundColor = ThemaManager.shared.lightColor
        bgView.backgroundColor = ThemaManager.shared.mainColor
        explainLabel.text = "정해진 시간을 완료하고, 나무를 성장시켜보세요!"
        imageView.image = .appleTree
    }
    
    func configureSecondPage() {
        explainLabel.text = "설정한 시간을 완료하지 않고 앱을 나가면 나무가 시들어요."
        imageView.image = .appletreeDie
    }
}
