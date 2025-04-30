//
//  RxCocoa.swift
//  ThirdPartyLibrary
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public extension UIViewController {
    var viewDidLoadEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewDidLoad)).map { _ in }
    }
    var viewDidAppearEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewDidAppear)).map { _ in }
    }
}
