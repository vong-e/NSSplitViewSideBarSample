//
//  NSViewController+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/02.
//

import AppKit

extension NSViewController {
    /// 'NSViewController'를 'NSSplitViewItem'로 변환
    func toSplitViewItem() -> NSSplitViewItem {
        return NSSplitViewItem(viewController: self)
    }
}
