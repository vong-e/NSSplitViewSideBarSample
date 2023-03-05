//
//  SideBarApplication.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import AppKit

struct SideBarApplication: Equatable {
    var id: Int
    var title: String
    var logo: NSImage
    var url: URL
    var backgroundColor: NSColor
    
    init(id: Int, title: String, logo: NSImage, backgroundColor: NSColor, url: URL) {
        self.id = id
        self.title = title
        self.logo = logo
        self.url = url
        self.backgroundColor = backgroundColor
    }
}
