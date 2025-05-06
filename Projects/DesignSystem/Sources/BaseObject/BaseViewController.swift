//
//  BaseViewController.swift
//  DesignSystem
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import ThirdPartyLibrary

import RxSwift

open class BaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    open func configureUI() { }
    open func configureLayout() { }
    
    open func showAlert(
        title: String?,
        message: String? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        
        let okAction = UIAlertAction(title: "확인", style: .destructive ) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

