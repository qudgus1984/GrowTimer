//
//  FirstPageViewController.swift
//  Present
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import ThirdPartyLibrary
import DesignSystem

import SnapKit
import ReactorKit
import RxSwift

final class FirstPageViewController: BaseViewController, View {
    
    let mainview = FirstPageView()
    
    override func loadView() {
        super.view = mainview
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.mainview.imageView.clipsToBounds = true
            self.mainview.imageView.layer.cornerRadius = self.mainview.imageView.frame.width / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.explainLabel.text = "정해진 시간을 완료하고, 나무를 성장시켜보세요!"
        mainview.imageView.image = .appleTree

        bind(reactor: FirstPageReactor())
    }
    
    func bind(reactor: FirstPageReactor) {
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.themaNumber }
            .bind(with: self) { owner, num in
                owner.mainview.imageView.backgroundColor = ThemaManager.shared.lightColor
                owner.mainview.bgView.backgroundColor = ThemaManager.shared.mainColor
            }
            .disposed(by: disposeBag)
    }
}

final class FirstPageView: BaseView {
    

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
