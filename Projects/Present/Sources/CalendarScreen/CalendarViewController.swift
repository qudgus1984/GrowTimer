//
//  CalendarViewController.swift
//  Present
//
//  Created by Den on 5/6/25.
//  Copyright © 2025 Den. All rights reserved.
//

import UIKit

import Utility
import DesignSystem
import ThirdPartyLibrary

import RxSwift
import ReactorKit
import FSCalendar

final class CalendarViewController: BaseViewController {
    
    private let mainView = CalendarView()
    
    override func loadView() {
        view = mainView
    }
    
    init(reactor: CalendarReactor) {
        super.init()
        self.reactor = reactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        
        // 테이블뷰 설정
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func setCalendar() {
        mainView.calendarView.dataSource = self
        mainView.calendarView.delegate = self
    }
}

extension CalendarViewController: View {
    func bind(reactor: CalendarReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    func bindAction(reactor: CalendarReactor) {
        // 뷰가 로드될 때 Action 전달
        viewDidLoadEvent
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 날짜 선택 시 Action 전달
        mainView.calendarView.rx.didSelect
            .map { Reactor.Action.selectDate($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(reactor: CalendarReactor) {
        // 유저 태스크 변경 시 캘린더 리로드
        reactor.state
            .map { $0.userTasks }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.mainView.calendarView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // 테이블뷰 데이터 변경 시 리로드
        reactor.state
            .map { ($0.dailyTotalTime, $0.yesterdayTotalTime, $0.monthlySuccessCount) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.mainView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell") as? CalendarTableViewCell,
              let reactor = self.reactor else {
            return UITableViewCell()
        }
        
        let totalTime = reactor.currentState.dailyTotalTime
        let yesterdayTotalTime = reactor.currentState.yesterdayTotalTime
        let monthlyCount = reactor.currentState.monthlySuccessCount
        
        let hour = totalTime / 60
        let minutes = totalTime % 60
        
        switch indexPath.row {
        case 0:
            if hour == 0 {
                cell.explainLabel.text = "오늘 \(minutes)분 만큼 성장하셨네요"
            } else {
                cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            }
            
        case 1:
            if yesterdayTotalTime == 0 {
                cell.explainLabel.text = "어제는 성장하지 않으셨군요!!"
            } else {
                let removeNum = totalTime - yesterdayTotalTime
                let removeHour = abs(removeNum) / 60
                let removeMinutes = abs(removeNum) % 60
                
                if removeNum < 0 {
                    cell.explainLabel.text = "어제보다 \(removeHour)시간 \(removeMinutes)분 덜 했어요 😭"
                } else if removeNum > 0 {
                    cell.explainLabel.text = "어제보다 \(removeHour)시간 \(removeMinutes)분 더 나아갔어요!"
                } else {
                    cell.explainLabel.text = "한결같은 당신의 꾸준함을 응원합니다 :D"
                }
            }
            
        case 2:
            cell.explainLabel.text = "이번 달에는 \(monthlyCount)번 성공하셨어요 👍🏻"
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let reactor = self.reactor else { return nil }
        
        // State에서 필요한 정보 가져오기
        let tasks = reactor.currentState.userTasks.filter { task in
            // 날짜 비교 로직 (같은 날짜인지 확인)
            return Calendar.current.isDate(task.startTime, inSameDayAs: date)
        }
        
        if tasks.isEmpty {
            return nil
        } else {
            let totalStudyTime = tasks.reduce(0) { $0 + $1.settingTime }
            
            switch totalStudyTime/3600 {
            case 0:
                return "\(totalStudyTime%3600 / 60)분"
            default:
                if totalStudyTime%3600 / 60 == 0 {
                    return "\(totalStudyTime/3600)시간"
                } else {
                    return "\(totalStudyTime/3600):\(totalStudyTime%3600 / 60)"
                }
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        guard let reactor = self.reactor else { return nil }
        
        // State에서 필요한 정보 가져오기
        let tasks = reactor.currentState.userTasks.filter { task in
            // 날짜 비교 로직
            return Calendar.current.isDate(task.startTime, inSameDayAs: date)
        }
        
        if tasks.isEmpty {
            return nil
        } else {
            let totalStudyTime = tasks.reduce(0) { $0 + $1.settingTime }
            return dateChangedIcon(time: totalStudyTime)
        }
    }
    
    private func dateChangedIcon(time: Int) -> UIImage? {
        let resizeImage = mainView.resizeImage
        
        switch time {
        case 0:
            return resizeImage(.seeds, 20, 20)
        case 1...7199:
            return resizeImage(.sprout, 20, 20)
        case 7200...14399:
            return resizeImage(.blossom, 20, 20)
        case 14400...21599:
            return resizeImage(.apple, 20, 20)
        case 21600...:
            return resizeImage(.appleTree, 20, 20)
        default:
            return nil
        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
//final class CalendarViewController: BaseViewController {
//    
//    private let mainView = CalendarView()
//    
//    override func loadView() {
//        view = mainView
//    }
//    
//    init(reactor: CalendarReactor) {
//        super.init()
//        self.reactor = reactor
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setCalendar()
//    }
//    
//    func setCalendar() {
//        mainView.calendarView.dataSource = self
//        mainView.calendarView.delegate = self
//    }
//}
//
//extension CalendarViewController: View {
//    func bind(reactor: CalendarReactor) {
//        bindAction(reactor: reactor)
//        bindState(reactor: reactor)
//    }
//    
//    func bindAction(reactor: CalendarReactor) {
//        viewDidLoadEvent
//        .map { Reactor.Action.viewDidLoad }
//        .bind(to: reactor.action)
//        .disposed(by: disposeBag)
//    
//    // 날짜 선택 시 Action 전달
//        mainView.calendarView.rx.didSelect
//        .map { Reactor.Action.selectDate($0) }
//        .bind(to: reactor.action)
//        .disposed(by: disposeBag)
//    }
//    
//    func bindState(reactor: CalendarReactor) {
//        
//    }
//}
//
//extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
//    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        guard let reactor = self.reactor else { return nil }
//        
//        return nil
//        
//    }
//}
//
