//
//  NSColor+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import AppKit

extension NSColor {
    // Get Point Color
    static func getPoint(color: PointColor) -> NSColor {
        return NSColor(named: color.rawValue)!
    }
    
    /// Get Background Color
    static func getBackground(color: BackgroundColor) -> NSColor {
        return NSColor(named: color.rawValue)!
    }
    
    /// Get Text Color
    static func getText(color: TextColor) -> NSColor {
        return NSColor(named: color.rawValue)!
    }
}

/// Point Color
enum PointColor: String {
    case primary = "p_primary"
}

/// Background Color
enum BackgroundColor: String {
    case base = "bg_base"
    case light = "bg_light"
}

/// Text Color
enum TextColor: String {
    case primary = "text_primary"
}
