//
//  PageNationViewController.swift
//  Present
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import ThirdPartyLibrary
import DesignSystem
import Utility

import RxSwift
import RxCocoa
import ReactorKit

final class PageNationViewController: UIPageViewController, View {
    
    var disposeBag = DisposeBag()
    
    lazy var navigationView: UIView = {
        let view = UIView()
        return view
    }()

    //뷰컨트롤러 배열

    lazy var vc1: UIViewController = {
        let vc = FirstPageViewController()
        vc.view.backgroundColor = .red

        return vc
    }()

    lazy var vc2: UIViewController = {
        let vc = SecondPageViewController()
        vc.view.backgroundColor = .green

        return vc
    }()

    lazy var vc3: UIViewController = {
        let vc = FinalPageViewController()
        vc.view.backgroundColor = .blue

        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewDidLoad()에서 호출
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        UserDefaults.standard.set(UIScreen.main.brightness, forKey: "bright")
        print(UIScreen.main.brightness)
        
        configure()
        setupDelegate()
        

    }
    
    func bind(reactor: PageNationReactor) {
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoadTrigger }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.themaNumber }
            .bind(with: self) { owner, num in
                owner.navigationView.backgroundColor = ThemaManager.shared.mainColor
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(72)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)

        func setupDelegate() {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

}

extension PageNationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
