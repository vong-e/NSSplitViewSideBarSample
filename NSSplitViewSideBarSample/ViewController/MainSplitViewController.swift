//
//  MainSplitViewController.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

final class MainSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
    }
    
}
