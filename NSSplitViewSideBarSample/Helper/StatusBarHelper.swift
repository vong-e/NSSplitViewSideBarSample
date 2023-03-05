//
//  StatusBarHelper.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Cocoa

import RxCocoa
import RxSwift

final class StatusBarHelper {
    static let shared = StatusBarHelper()
    
    private var statusItem: NSStatusItem!
    
    private var sideBarApplicationVC: SideBarApplicationViewController?
    
    var disposeBag = DisposeBag()
    
    private init() { }
    
    /// Init status bar item
    func initStatusBarItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        guard let statusBarBtn = statusItem?.button else {
            print("StatusBar is Full. Restart after remove some status bar Applications.")
            NSApp.terminate(self)
            return
        }
        
        let statusBarImage: NSImage = .getStatusBar(image: .normal)
        statusBarImage.size = NSSize(width: 18.0, height: 18.0)
        statusBarBtn.image = statusBarImage
   
        setStatusBarMenu()
    }
}

// MARK: - Setting StatusBar
extension StatusBarHelper {
    /// Set statusbar menu
    func setStatusBarMenu() {
        let menu = NSMenu()
        let menuItem = NSMenuItem()
        
        if let sideBarApplication = SideBarApplicaitonHelper.shared.getSideBarApplicaitonInfo(of: DBService.getStatusBarApplicationID()) {
            let sideBarVC: SideBarApplicationViewController = SideBarApplicationViewController(application: sideBarApplication)
            self.sideBarApplicationVC = sideBarVC
            sideBarVC.view.setFrameSize(.init(width: 400, height: 600))
            
            menuItem.view = sideBarVC.view
            menu.addItem(menuItem)
        } else {
            menu.addItem(withTitle: "설정된 StatusBar App이 없습니다.", action: nil, keyEquivalent: "")
        }   
        
        self.statusItem.menu = menu
    }
}
