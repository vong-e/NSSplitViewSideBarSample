//
//  DBService.swift
//  NSSplitViewSideBarSample
//
//  Created by vongvorovongvong on 2023/03/05.
//

import Foundation

typealias SideBarApplicationID = Int

final class DBService {
    /// SideBar applicaiton의 width 설정
    /// - Parameter width: 설정할 width
    /// - Parameter appID: SideBar applicaiton의 ID
    /// - Returns: SideBar Applicaiton의 width
    static func setSideBarApplicaiton(width: CGFloat, appID: SideBarApplicationID) {
        UserDefaults.standard.set(width, forKey: "SideBarApp_\(appID)_width")
    }
    
    /// SideBar applicaiton의 width를 가져옴
    /// - Parameter appID: SideBar applicaiton의 ID
    /// - Returns: SideBar applicaiton의 width
    static func getSideBarApplicationWidth(of appID: SideBarApplicationID) -> CGFloat {
        return UserDefaults.standard.object(forKey: "SideBarApp_\(appID)_width") as? CGFloat ?? 300
    }
    
    /// StatusBar에서 보여줄 application 설정
    /// - Parameter appID: 설정할 application의 ID
    static func setStatusBarAppication(appID: SideBarApplicationID) {
        UserDefaults.standard.set(appID, forKey: "StatusBarAppication")
    }
    
    /// StatusBar에서 보여줄 applicaiton의 ID를 가져옴
    /// - Returns: StatusBar applicaition의 ID
    static func getStatusBarApplicationID() -> SideBarApplicationID? {
        return UserDefaults.standard.object(forKey: "StatusBarAppication") as? SideBarApplicationID
    }
}
