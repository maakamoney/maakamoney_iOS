//
//  SettingsCoordinator.swift
//  MaakanMoney
//
//  Created by Anand M on 28/03/24.
//

import Foundation
import SwiftUI

final class SettingsCoordinator: Hashable {
  
    var id: UUID
    var event: SettingsCoordinatorEvents
    var dashbaordNavigation: DashbaordNavigation
    
    static var sharedSettingsCoordinator = SettingsCoordinator()
    
    private init(event: SettingsCoordinatorEvents = .start, dashbaordNavigation: DashbaordNavigation = DashbaordNavigation()) {
        id = UUID()
        self.event = event
        self.dashbaordNavigation = dashbaordNavigation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SettingsCoordinator, rhs: SettingsCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func start() -> some View {
        return SettingsView(settingsNavigation: SettingsNavigation(popDashboardView: {
            self.dashbaordNavigation.popDashboardView?()
        }))
    }

    @ViewBuilder
    func getViewForEvent(viewModel: SettingsViewModel) -> some View {
        switch event {
        case .showSecurityShield:
            SecurityShieldView(settingsViewModel: viewModel)
        case .showReminders:
            RemindersView(settingsViewModel: viewModel)
        case .showHelpAndSupport:
            HelpAndSupportView.init(settingsViewModel: viewModel)
        case .showAbout:
            TermsAndConditionView.init(isFromLogin: false)
        default:
            EmptyView()
        }
    }
}

struct SettingsNavigation {
    var popDashboardView: (() -> ())?
}
