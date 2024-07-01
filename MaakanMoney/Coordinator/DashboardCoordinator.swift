//
//  TabbarCoordinator.swift
//  MaakanMoney
//
//  Created by Anand M on 28/03/24.
//

import Foundation
import SwiftUI

final class DashboardCoordinator: Hashable {
  
    var id: UUID
    var event: DashboardCoordinatorEvents
    var appNavigation: AppNavigation
    
    static var sharedDashboardCoordinator = DashboardCoordinator()
    
    private init(event: DashboardCoordinatorEvents = .start, appNavigation: AppNavigation = AppNavigation()) {
        id = UUID()
        self.event = event
        self.appNavigation = appNavigation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DashboardCoordinator, rhs: DashboardCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func start() -> some View {
        let dashboardView = DashboardView(dashbaordNavigation: .init(popDashboardView: {
            self.appNavigation.popDashboardView?()
        }))
        return dashboardView
    }

    func getViewForEvent() -> some View {
        switch event {
        case .start:
            return start()
        }
    }
}

struct DashbaordNavigation {
    var popDashboardView: (() -> ())?
}
