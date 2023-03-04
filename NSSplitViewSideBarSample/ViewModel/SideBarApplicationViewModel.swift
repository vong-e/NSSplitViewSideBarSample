//
//  SideBarApplicationViewModel.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Foundation

class SideBarApplicationViewModel {
    private var sideBarWidth: CGFloat = 200
    private var sideBarApplication: SideBarApplication
    
    init(sideBarApplication: SideBarApplication) {
        self.sideBarApplication = sideBarApplication
    }
}
