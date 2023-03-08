//
//  MainSplitCoordinator.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/09.
//

import Cocoa

import RxCocoa
import RxSwift

final class MainSplitCoordinator: Coordinator {

    private let windowController: NSWindowController
    private var mainSplitViewController: MainSplitViewController?
    
    private var selectedSideBarID: Int?
    
    var childCoordinators: [Coordinator] = []
    
    // Rx
    private let disposeBag = DisposeBag()
    
    init(windowController: NSWindowController) {
        self.windowController = windowController
    }
    
    func start() {
        let mainSplitViewController =  MainSplitViewController()
        self.mainSplitViewController = mainSplitViewController
        
        windowController.contentViewController = mainSplitViewController
        
        setInitialSplitViewItems()
        binding()
    }
    
    private func setInitialSplitViewItems() {
        let webViewSplitViewItem = WebViewContentViewController().toSplitViewItem()
        mainSplitViewController?.addSplitViewItem(webViewSplitViewItem)
        
        let sideBarSplitViewItem = SideBarViewController().toSplitViewItem()
        mainSplitViewController?.addSplitViewItem(sideBarSplitViewItem)
    }
    
    // MARK: - Binding
    private func binding() {
        /// 선택된 SideBarApplication ID 옵저빙
        SideBarApplicaitonHelper.shared
            .selectedApplicationIDObservable
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self,
                   onNext: { owner, selectedID in
                owner.addSideBarApplicationPanel(of: selectedID)
            })
            .disposed(by: disposeBag)
    }
    
    func addSideBarApplicationPanel(of id: SideBarApplicationID?) {
        guard let sideBarApplication = SideBarApplicaitonHelper.shared.getSideBarApplicaitonInfo(of: id) else {
            removeSideBarApplicationPanel(animate: true)
            return
        }
        
        /// 기존 SideBar Application 닫아줌
        removeSideBarApplicationPanel(animate: false)
        
        let sideBarApplicationViewController = SideBarApplicationViewController(application: sideBarApplication)
        let sideBarApplicationVCItem = sideBarApplicationViewController.toSplitViewItem()
        sideBarApplicationVCItem.minimumThickness = 300
        
        self.mainSplitViewController?.insertSplitViewItem(sideBarApplicationVCItem, at: 1)
        
        let sideBarApplicationWidth: CGFloat = DBService.getSideBarApplicationWidth(of: sideBarApplication.id)
        let sideBarVCWidth: CGFloat = 60
        let dividerWidth: CGFloat = 2 // divier 2개의 최소 width 1씩
        let windowFrame: NSRect = self.windowController.window?.frame ?? .zero

        if windowFrame.width < sideBarApplicationWidth + sideBarVCWidth + dividerWidth {
            self.windowController.window?.setFrame(.init(origin: windowFrame.origin, size: .init(width: sideBarApplicationWidth + sideBarVCWidth + dividerWidth, height: windowFrame.height)), display: true)
            mainSplitViewController?.splitView.setPosition(0, ofDividerAt: 0)
        } else {
            let position: CGFloat = windowFrame.width - sideBarApplicationWidth - sideBarVCWidth - dividerWidth
            mainSplitViewController?.splitView.setPosition(position, ofDividerAt: 0)
        }
    }
    
    private func removeSideBarApplicationPanel(animate: Bool) {
        guard let sideBarApplicationVCItem = self.mainSplitViewController?.splitViewItems.first(where: { $0.viewController.isKind(of: SideBarApplicationViewController.self) }) else {
            return
        }
        
        if animate {
            NSAnimationContext.runAnimationGroup ({ context in
                sideBarApplicationVCItem.animator().isCollapsed = true
            }, completionHandler: {
                self.mainSplitViewController?.removeSplitViewItem(sideBarApplicationVCItem)
            })
        } else {
            mainSplitViewController?.removeSplitViewItem(sideBarApplicationVCItem)
        }
    }
}
