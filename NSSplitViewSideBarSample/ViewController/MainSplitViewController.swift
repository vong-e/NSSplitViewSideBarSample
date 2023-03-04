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
    private var sideBarApplicaitonVC: SideBarApplicationViewController?
    
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
        setConstraints()
        binding()
    }
    
    // MARK: - Configure
    private func configure() {
        let webViewSplitViewItem = self.webViewContentVC.toSplitViewItem()
        self.addSplitViewItem(webViewSplitViewItem)
        
        let sideBarSplitViewItem = self.sideBarVC.toSplitViewItem()
        self.addSplitViewItem(sideBarSplitViewItem)
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
                   onNext: { owner, selectedID in
                owner.addSideBarApplicationPanel(of: selectedID)
            })
            .disposed(by: disposeBag)
    }
    
    private func addSideBarApplicationPanel(of id: SideBarApplicationID?) {
        guard let sideBarApplication = SideBarApplicaitonHelper.shared.getSideBarApplicaitonInfo(of: id) else {
            self.removeSideBarApplicaitonPanel(animate: true)
            return
        }
        
        removeSideBarApplicaitonPanel(animate: false)
        
        let sideBarApplicationViewController = SideBarApplicationViewController(application: sideBarApplication)
        sideBarApplicationViewController.view.setFrameSize(.init(width: 300, height: self.view.frame.height))
        self.sideBarApplicaitonVC = sideBarApplicationViewController

        let sideBarApplicationVCItem = sideBarApplicationViewController.toSplitViewItem()
        sideBarApplicationVCItem.minimumThickness = 300
        print("sideBarApplicationVCItem ", sideBarApplicationVCItem.viewController.view.frame)
        self.insertSplitViewItem(sideBarApplicationVCItem, at: 1)
        
        let sideBarApplicationWidth: CGFloat = DBService.getSideBarApplicationWidth(of: sideBarApplication.id)
        let sideBarVCWidth: CGFloat = 60
        let dividerWidth: CGFloat = 2 // divier 2개의 최소 width 1씩
        let windowFrame: NSRect = self.view.window?.frame ?? .zero

        if windowFrame.width < sideBarApplicationWidth + sideBarVCWidth + dividerWidth {
            self.view.window?.setFrame(.init(origin: windowFrame.origin, size: .init(width: sideBarApplicationWidth + sideBarVCWidth + dividerWidth, height: windowFrame.height)), display: true)
            splitView.setPosition(0, ofDividerAt: 0)
        } else {
            let position: CGFloat = windowFrame.width - sideBarApplicationWidth - sideBarVCWidth - dividerWidth
            splitView.setPosition(position, ofDividerAt: 0)
        }
    }
    
    private func removeSideBarApplicaitonPanel(animate: Bool) {
        guard let sideBarApplicationVCItem = self.splitViewItems.first(where: { $0.viewController.isKind(of: SideBarApplicationViewController.self) }) else {
            return
        }
        
        if animate {
            NSAnimationContext.runAnimationGroup ({ context in
                sideBarApplicationVCItem.animator().isCollapsed = true
            }, completionHandler: {
                self.removeSplitViewItem(sideBarApplicationVCItem)
                self.sideBarApplicaitonVC = nil
            })
        } else {
            self.removeSplitViewItem(sideBarApplicationVCItem)
            self.sideBarApplicaitonVC = nil
        }
    }
    
    /// Divider Size
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        var sideBarDividerIndex: Int {
            if sideBarApplicaitonVC == nil {
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
