//
//  SideBarApplicaitonHelper.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Foundation

import RxCocoa
import RxSwift

final class SideBarApplicaitonHelper {
    static let shared = SideBarApplicaitonHelper()
    
    // Rx
    private let disposeBag = DisposeBag()
    
    var sideBarApplicaitonListObservable: Observable<[SideBarApplication]> {
        return sideBarApplicationListRelay.asObservable()
    }
    private var sideBarApplicationListRelay = BehaviorRelay<[SideBarApplication]>(value: [])
    
    var selectedApplicationIDObservable: Observable<Int?> {
        return selectedApplicationIDRelay.asObservable()
    }
    private var selectedApplicationIDRelay = BehaviorRelay<Int?>(value: nil)
    
    private init() {
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        SideBarApplicationMockData.allCases.forEach { applicaitonData in
            sideBarApplicationListRelay.primaryAppend(element: applicaitonData.getSideBarApplication())
        }
    }
    
    /// SideBar application의 선택 상태 설정
    /// - Parameters:
    ///   - selected: SideBar applicaiton의 선택 여부
    ///   - id: SideBar applicaiton의 ID
    func setApplication(selected: Bool, id: Int) {
        if selectedApplicationIDRelay.value == id {
            selectedApplicationIDRelay.accept(nil)
        } else {
            selectedApplicationIDRelay.accept(id)
        }
    }
}
