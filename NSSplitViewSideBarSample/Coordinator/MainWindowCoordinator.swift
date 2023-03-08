//
//  MainWindowCoordinator.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/09.
//

import Foundation

final class MainWindowCoordinator: Coordinator {
    private let mainWindowController: MainWindowController
    var childCoordinators: [Coordinator] = []
    
    init(mainWindowController: MainWindowController) {
        self.mainWindowController = mainWindowController
    }
    
    func start() {
        mainWindowController.showWindow(nil)
    }
}
