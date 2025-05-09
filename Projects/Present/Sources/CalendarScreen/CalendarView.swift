//
//  CalendarView.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem
import ThirdPartyLibrary

import SnapKit
import FSCalendar

final class CalendarView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = ThemaManager.shared.lightColor
        view.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reuseIdentifier)
        return view
    }()
    
    let calendarView: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = ThemaManager.shared.lightColor
        view.appearance.selectionColor = ThemaManager.shared.calendarChoiceColor
        view.appearance.todayColor = ThemaManager.shared.mainColor
        
        view.appearance.weekdayFont = FontManager.shared.font16
        view.appearance.weekdayTextColor = ThemaManager.shared.mainColor.withAlphaComponent(0.9)
        view.appearance.headerTitleFont = FontManager.shared.font24
        view.appearance.headerTitleColor = ThemaManager.shared.mainColor.withAlphaComponent(0.9)
        view.appearance.headerTitleAlignment = .center
        return view
    }()
    
    override func configureUI() {
        [calendarView,tableView].forEach {
            addSubview($0)
        }
        
        let weekDictionary: [Int : String] = [0 : "일", 1 : "월", 2 : "화", 3 : "수", 4 : "목", 5 : "금", 6 : "토"]
        for i in 0...6 {
            calendarView.calendarWeekdayView.weekdayLabels[i].text = weekDictionary[i]
        }
        
    }
    
    override func configureLayout() {
        
        calendarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(calendarView.snp.bottom)
        }
    }
}

extension CalendarView {
    func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? .appleTree
        UIGraphicsEndImageContext()
        return newImage
    }
}
