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
    
    var selectedApplicationIDObservable: Observable<SideBarApplicationID?> {
        return selectedApplicationIDRelay.asObservable()
    }
    private var selectedApplicationIDRelay = BehaviorRelay<SideBarApplicationID?>(value: nil)
    
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
    func setApplication(selected: Bool, id: SideBarApplicationID) {
        if selectedApplicationIDRelay.value == id {
            selectedApplicationIDRelay.accept(nil)
        } else {
            selectedApplicationIDRelay.accept(id)
        }
    }
    
    /// SideBarApplicaiton 을 가져옴
    /// - Parameter id: 가져올 side bar applicaiton의 ID
    /// - Returns: SideBar applicaiton 정보
    func getSideBarApplicaitonInfo(of id: SideBarApplicationID?) -> SideBarApplication? {
        print("넘어온거: \(self.sideBarApplicationListRelay.value.first(where: { $0.id == id }))")
//        print("lsit :\(sideBarApplicationListRelay.value)")
        return self.sideBarApplicationListRelay.value.first(where: { $0.id == id })
    }
}
