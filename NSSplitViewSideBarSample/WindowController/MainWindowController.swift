//
//  MainWindowController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

final class MainWindowController: NSWindowController {

    // MARK: - Initialize
    convenience init() {
        self.init(windowNibName: "MainWindowController")
    }
    
    // MARK: - Life Cycle
    override func windowDidLoad() {
        super.windowDidLoad()
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        self.contentViewController = MainSplitViewController()
    }
}
