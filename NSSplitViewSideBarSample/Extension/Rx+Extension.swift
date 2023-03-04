//
//  Rx+Extension.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection, Element.Element: Equatable {
    /// Append element with no duplicate
    func primaryAppend(element: Element.Element) {
        var currentValue = self.value
        if currentValue.contains(element) {
            return
        }
        currentValue.append(element)
        self.accept(currentValue)
    }
}
