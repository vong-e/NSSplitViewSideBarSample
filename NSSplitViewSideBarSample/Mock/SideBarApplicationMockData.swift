//
//  SideBarApplication.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import AppKit

enum SideBarApplicationMockData: Int, CaseIterable {
    case translate = 0
    case webtoon
    case memo
    case timer
    
    var id: Int {
        return self.rawValue
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
    
    var url: URL {
        switch self {
        case .translate:
            return URL(string: "https://papago.naver.com")!
        case .webtoon:
            return URL(string: "https://m.comic.naver.com")!
        case .memo:
            return URL(string: "https://m.memo.naver.com")!
        case .timer:
            return URL(string: "https://vclock.com/timer")!
        }
    }
    
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
    
    func getSideBarApplication() -> SideBarApplication {
        return .init(id: self.id, title: self.title, logo: self.logo, backgroundColor: self.backgroundColor, url: self.url)
    }
}
