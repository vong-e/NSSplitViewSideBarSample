//
//  AppDelegate.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/01.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    private let statusBarHelper = StatusBarHelper.shared
    var mainWindowCoordinator: MainWindowCoordinator?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        UserDefaults.standard.synchronize()
        
        
        
        mainWindowCoordinator = MainWindowCoordinator(mainWindowController: .init())
        mainWindowCoordinator?.start()
        statusBarHelper.initStatusBarItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if flag {
            return true
        }
        
        mainWindowCoordinator?.start()
        return false
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
