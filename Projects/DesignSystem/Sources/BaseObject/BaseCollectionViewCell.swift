//
//  BaseCollectionViewCell.swift
//  DesignSystem
//
//  Created by Den on 4/29/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

open class BaseCVCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureLayout() { }
}
