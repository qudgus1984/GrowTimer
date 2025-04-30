//
//  FinalPageViewController.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

final class FinalPageViewController: UIViewController {

    let mainview = PaginationFinalView()

    override func loadView() {
        super.view = mainview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        finishButtonClicked()
        mainview.explainLabel.text = "보유한 코인으로 테마나 폰트를 구입할 수 있어요!\n(출석 시 + 10코인)"
        mainview.imageView.image = .dollor
    }
    
    func finishButtonClicked() {
        mainview.finishButton.addTarget(self, action: #selector(finishButtonClickedCountDown), for: .touchUpInside)
        
    }
    
    
    
    @objc func finishButtonClickedCountDown() {
        UserDefaults.standard.set(true, forKey: "firstStart")

    }
}

final class PaginationFinalView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()
    
    let explainLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = FontManager.shared.font36
        label.textColor = .white
        return label
    }()

    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = ThemaManager.shared.lightColor
        return view
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = ThemaManager.shared.lightColor
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        
        self.finishButton.clipsToBounds = true
        self.finishButton.layer.cornerRadius = 12
    }

    override func configureUI() {
        [bgView, explainLabel, imageView, finishButton].forEach {
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
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.height.equalTo(60)
            make.leading.equalTo(safeAreaLayoutGuide).offset(60)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-60)
            
        }
    }
}
