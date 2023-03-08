//
//  MainSplitViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

import RxCocoa
import RxSwift
import SnapKit

final class MainSplitViewController: NSSplitViewController {

    private var isSideBarApplicationShowing: Bool = false
    
    // Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    // MARK: - Set UI
    private func setConstraints() {
        self.view.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(500)
            make.height.greaterThanOrEqualTo(350)
        }
    }
    
    // MARK: - Binding
    private func binding() {
        SideBarApplicaitonHelper.shared
            .selectedApplicationIDObservable
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self,
                   onNext: { owner, selectedIndex in
                owner.isSideBarApplicationShowing = (selectedIndex != nil)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Divider Size
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {

        var sideBarDividerIndex: Int {
            if isSideBarApplicationShowing {
                return 0
            } else {
                return 1
            }
        }

        if dividerIndex == sideBarDividerIndex {
            /// SideBar divier는 선택하지 못하도록 함
            return .zero
        }
        return proposedEffectiveRect
    }
}
