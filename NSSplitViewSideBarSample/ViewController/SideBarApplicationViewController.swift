//
//  SideBarApplicationViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Cocoa

import RxCocoa
import RxSwift
import SnapKit

final class SideBarApplicationViewController: NSViewController {
    
    private let applicaiton: SideBarApplication
    
    // Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    init(application: SideBarApplication) {
        self.applicaiton = application
        super.init(nibName: nil, bundle: nil)
        binding()
        print("Sidebar loaded")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        let box = NSBox(fillColor: applicaiton.backgroundColor)
        self.view = box
    }
    
    // MARK: - Binding
    private func binding() {
        self.view.rx
            .observe(\.frame)
            .asDriver(onErrorJustReturn: .zero)
            .skip(1) // SplitViewItem 으로 추가될 때 불리는 첫 번째 call 무시
            .drive(with: self,
                   onNext: { owner, frame in
                let width = max(frame.width, 300)
                DBService.setSideBarApplicaiton(width: width, appID: owner.applicaiton.id)
            })
            .disposed(by: disposeBag)
    }
}
