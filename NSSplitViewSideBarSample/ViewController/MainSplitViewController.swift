//
//  MainSplitViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        let webViewSplitViewItem = webViewContentVC.toSplitViewItem()
        self.addSplitViewItem(webViewSplitViewItem)
        
        let sideBarSplitViewItem = sideBarVC.toSplitViewItem()
        self.addSplitViewItem(sideBarSplitViewItem)
        sideBarSplitViewItem.minimumThickness = 40
    }
    
    /// Divider Size
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return NSRect.zero
    }
}
