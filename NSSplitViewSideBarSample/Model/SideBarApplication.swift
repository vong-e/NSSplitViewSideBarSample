//
//  SideBarApplication.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import AppKit

enum SideBarApplication: CaseIterable {
    case translate
    case webtoon
    case memo
    case timer
    
    var backgroundColor: NSColor {
        switch self {
        case .translate:
            return .blue
        case .webtoon:
            return .green
        case .memo:
            return .yellow
        case .timer:
            return .gray
        }
    }
    
    var title: String {
        switch self {
        case .translate:
            return "번역"
        case .webtoon:
            return "웹툰"
        case .memo:
            return "메모"
        case .timer:
            return "타이머"
        }
    }
    
    var logo: NSImage {
        switch self {
        case .translate:
            return .getSideBarAppLogo(image: .translate)
        case .webtoon:
            return .getSideBarAppLogo(image: .webtoon)
        case .memo:
            return .getSideBarAppLogo(image: .memo)
        case .timer:
            return .getSideBarAppLogo(image: .timer)
        }
    }
}
