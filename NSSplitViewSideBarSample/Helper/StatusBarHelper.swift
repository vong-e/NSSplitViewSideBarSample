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
        
        guard let sideBarApplication = SideBarApplicaitonHelper.shared.getSideBarApplicaitonInfo(of: DBService.getStatusBarApplicationID()) else {
            return
        }
        
        let sideBarVC: SideBarApplicationViewController = SideBarApplicationViewController(application: .init(id: sideBarApplication.id, title: sideBarApplication.title, logo: sideBarApplication.logo, backgroundColor: sideBarApplication.backgroundColor))
        self.sideBarApplicationVC = sideBarVC
        sideBarVC.view.setFrameSize(.init(width: 400, height: 200))
        
        menuItem.view = sideBarVC.view
        menu.addItem(menuItem)
        
        self.statusItem.menu = menu
    }
}
