//
//  NSImage+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/03.
//

import AppKit

extension NSImage {
    static func getSideBarAppLogo(image: SideBarAppLogo) -> NSImage {
        return NSImage(named: image.rawValue)!
    }
    
    static func getIcon(image: IconImage) -> NSImage {
        return NSImage(named: image.rawValue)!
    }
    
    static func getStatusBar(image: StatusBarImage) -> NSImage {
        return NSImage(named: image.rawValue)!
    }
}


enum SideBarAppLogo: String {
    case translate = "side_bar_app_logo_translate"
    case webtoon = "side_bar_app_logo_webtoon"
    case memo = "side_bar_app_logo_memo"
    case timer = "side_bar_app_logo_timer"
}

enum IconImage: String {
    case close = "ic_close"
}

enum StatusBarImage: String {
    case normal = "ic_statusBar"
}
