//
//  NSTextField+Extenson.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/06.
//

import AppKit

extension NSTextField {
    /// 스타일이 설정된 텍스트 필드 초기화
    /// - Parameters:
    ///   - font: text font
    ///   - color: text color
    ///   - isEditable: default: false
    ///   - isBordered: default: false
    ///   - isBezeled: default: false
    ///   - drawsBackground: default: false
    ///   - alignment: default: .natural
    ///   - maximumNumberOfLines: default: 1
    ///   - lineBreakMode: default: .byTruncatingTail
    ///   - focuseRingType: default: .default
    convenience init(font: NSFont,
                  color: NSColor,
                  isEditable: Bool = false,
                  isBordered: Bool = false,
                  isBezeled: Bool = false,
                  drawsBackground: Bool = false,
                  alignment: NSTextAlignment = .natural,
                  maximumNumberOfLines: Int = 1,
                  lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                  focuseRingType: NSFocusRingType = .default) {
        self.init()
        self.font = font
        self.textColor = color
        self.isEditable = isEditable
        self.isBordered = isBordered
        self.isBezeled = isBezeled
        self.drawsBackground = drawsBackground
        self.alignment = alignment
        self.maximumNumberOfLines = maximumNumberOfLines
        if self.maximumNumberOfLines <= 1 {
            self.lineBreakMode = lineBreakMode
        } else {
            self.cell?.truncatesLastVisibleLine = true
        }
        self.focusRingType = focuseRingType
    }
}
