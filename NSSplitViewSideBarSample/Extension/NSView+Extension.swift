//
//  NSView+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/04.
//

import AppKit

// MARK: - Tracking Area
extension NSView {
    /// Tracking area 설정
    func setTrackingArea() {
        if self.trackingAreas.count == 0 {
            let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
            self.addTrackingArea(trackingArea)
        } else {
            self.updateTrackingAreas()
        }
    }
}
