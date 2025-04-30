//
//  HomeView.swift
//  Present
//
//  Created by Den on 4/30/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import DesignSystem
import Utility
import SnapKit

final class HomeView: BaseView {

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()
    
    let famousSayingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FontManager.shared.font24
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .seeds
        view.backgroundColor = ThemaManager.shared.mainColor
        return view
    }()
    
    let countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font44
        label.textAlignment = .center
        return label
    }()
    
    let stopCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontManager.shared.font16
        label.textAlignment = .center
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.backgroundColor = .clear

        return button
    }()
    
    let circularProgressBar: CircularProgress = {

        let circularProgressBar = CircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.width * 0.65))
        
        circularProgressBar.progressColor = ThemaManager.shared.progressColor
        circularProgressBar.trackColor = ThemaManager.shared.lightColor
        circularProgressBar.tag = 101
        return circularProgressBar
    }()
    
    let containCoinView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let insetCoinView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.lightColor
        return view
    }()
    
    let totalCoinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontManager.shared.font12
        label.textColor = .white
        label.textAlignment = .center
        label.text = "8888"
       return label
    }()
    
    let coinImgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = .dollor
        return view
    }()
    
    let buttonIncludeView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemaManager.shared.lightColor
        return view
    }()

    override func configureUI() {
        
        [bgView, famousSayingLabel, iconImageView, circularProgressBar, countTimeLabel, buttonIncludeView, startButton, stopCountLabel, containCoinView, insetCoinView, totalCoinLabel, coinImgView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        famousSayingLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(0)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        
        circularProgressBar.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(circularProgressBar.snp.width)
            
        }

        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(circularProgressBar.snp.width)


        }
        
        countTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-28)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        stopCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(startButton.snp.bottom).offset(0)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        buttonIncludeView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(countTimeLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        startButton.snp.makeConstraints { make in
            make.edges.equalTo(buttonIncludeView)
        }
        
        containCoinView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalToSuperview().multipliedBy(0.20)
        }
        
        insetCoinView.snp.makeConstraints { make in
            make.edges.equalTo(containCoinView).inset(4)
        }
        
        coinImgView.snp.makeConstraints { make in
            make.leading.top.equalTo(containCoinView)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalTo(coinImgView.snp.height)
        }
        
        totalCoinLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImgView).offset(30)
            make.top.trailing.bottom.equalTo(insetCoinView)
        }
    }
    
    override func draw(_ rect: CGRect) {
        insetCoinView.clipsToBounds = true
        insetCoinView.layer.cornerRadius = 10
        
        buttonIncludeView.clipsToBounds = true
        buttonIncludeView.layer.cornerRadius = 12
    }
}

extension HomeView {
    func circularProgressBarConfigure(state: Bool) {
        if state {
            // 타이머 동작 중 상태에 맞는 UI 설정
            startButton.setTitle("중지", for: .normal)
        } else {
            // 타이머 중지 상태에 맞는 UI 설정
            startButton.setTitle("시작", for: .normal)
        }
    }
    
    func updateProgress(value: Float) {
        circularProgressBar.setProgressWithAnimation(duration: 0.01, value: value)
    }
}
