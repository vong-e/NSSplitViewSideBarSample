//
//  MainSplitViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

import RxCocoa
import RxSwift

final class MainSplitViewController: NSSplitViewController {
    
    private let webViewContentVC = WebViewContentViewController()
    private let sideBarVC = SideBarViewController()
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        binding()
    }
    
    // MARK: - Configure
    private func configure() {
        let webViewSplitViewItem = self.webViewContentVC.toSplitViewItem()
        self.addSplitViewItem(webViewSplitViewItem)
        
        let sideBarSplitViewItem = self.sideBarVC.toSplitViewItem()
        self.addSplitViewItem(sideBarSplitViewItem)
        sideBarSplitViewItem.minimumThickness = 60
        sideBarSplitViewItem.maximumThickness = 60
    }
    
    // MARK: - Binding
    private func binding() {
        SideBarApplicaitonHelper.shared
            .selectedApplicationIDObservable
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self,
                   onNext: { owner, selectedID in
                print("SELECTED ID: \(String(describing: selectedID))")
            })
            .disposed(by: disposeBag)
    }
    
    /// Divider Size
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return NSRect.zero
    }
}
