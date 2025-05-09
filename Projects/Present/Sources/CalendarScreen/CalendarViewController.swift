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
        configureNavigation()
        // 테이블뷰 설정
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func setCalendar() {
        mainView.calendarView.dataSource = self
        mainView.calendarView.delegate = self
    }
    
    private func configureNavigation() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = ThemaManager.shared.lightColor
        appearence.shadowColor = .clear

        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
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
            .map { ($0.firstIndexText, $0.secondIndexText, $0.thirdIndexText) }
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, data in
                print(data)
                owner.mainView.tableView.reloadData()
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
        
        cell.configure(firstIndexText: reactor.currentState.firstIndexText, secondIndexText: reactor.currentState.secondIndexText, thirdIndexText: reactor.currentState.thirdIndexText, index: indexPath)

        
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
            let totalStudyTime = tasks.filter { $0.success }.reduce(0) { $0 + $1.settingTime }
            
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
            let totalStudyTime = tasks.filter { $0.success }.reduce(0) { $0 + $1.settingTime }
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let reactor = self.reactor as? CalendarReactor else { return }

        Observable.just(date)
            .map { _ in Reactor.Action.selectDate(date) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
