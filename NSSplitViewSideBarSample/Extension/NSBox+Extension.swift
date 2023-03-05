//
//  NSBox+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/02.
//

import AppKit

extension NSBox {
    convenience init(cornerRadius: CGFloat = 0,
                     borderWidth: CGFloat = 0,
                     borderColor: NSColor = .clear,
                     fillColor: NSColor = .clear,
                     contentViewMargins: NSSize = .zero) {
        self.init()
        self.boxType = .custom
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.fillColor = fillColor
        self.contentViewMargins = contentViewMargins
    }
}
