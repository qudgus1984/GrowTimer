//
//  AlertView.swift
//  DesignSystem
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import ThirdPartyLibrary
import SnapKit

public class AlertView: BaseView {
    
    public let bgView: UIView = {
        let view = UIView()
        view.alpha = 0.35
        return view
    }()
    
    public let basePopupView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public let okButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public let okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public let cancelButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    public let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public let backgroundButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(title: String, subtitle: String, okButtonTitle: String, cancelButtonTitle: String) {
        self.init()
        titleLabel.text = title
        subtitleLabel.text = subtitle
        okButtonLabel.text = okButtonTitle
        cancelButtonLabel.text = cancelButtonTitle

    }
    
    public override func configureUI() {
        self.addSubview(bgView)
        self.addSubview(basePopupView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(okButtonLabel)
        self.addSubview(okButton)
        self.addSubview(cancelButtonLabel)
        self.addSubview(cancelButton)
        self.addSubview(backgroundButton)
    }
    
    public override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        basePopupView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(187)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(basePopupView.snp.top).inset(40)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(basePopupView)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(42)
            make.leading.trailing.equalTo(basePopupView)
        }
        
        okButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(basePopupView.snp.width).multipliedBy(0.5)
            make.leading.bottom.equalTo(basePopupView)
        }
        
        okButton.snp.makeConstraints { make in
            make.edges.equalTo(okButtonLabel)
        }
        
        cancelButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(basePopupView.snp.width).multipliedBy(0.5)
            make.trailing.bottom.equalTo(basePopupView)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.edges.equalTo(cancelButtonLabel)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(basePopupView.snp.top)
        }
    }
}
