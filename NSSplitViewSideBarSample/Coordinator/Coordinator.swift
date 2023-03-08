//
//  Coordinator.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/09.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
