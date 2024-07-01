//
//  DashboardViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import Foundation
import SwiftUI
import LocalAuthentication

class DashboardViewModel: ObservableObject {
    
    @Published var currentTab = 1
    
    let context = LAContext()
    var getNavigationBarTitle: String {
        switch currentTab {
        case 0:
            return MMConstants.TitleText.maakaMoney
        case 1:
            return MMConstants.TitleText.myGoals
        case 2:
            return MMConstants.TitleText.settings
        default:
            return MMConstants.emptyString
        }
    }
    
    func getSettingsCoordinator(popDashboardView: @escaping () -> ()) ->  SettingsCoordinator {
        let settingsCoordinator = SettingsCoordinator.sharedSettingsCoordinator
        settingsCoordinator.dashbaordNavigation = DashbaordNavigation(popDashboardView: {
            popDashboardView()
        })
        return settingsCoordinator
    }
    
    func authenticateUserLocally(isSuccess: (Bool) -> ()) {
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock Maaka Money") { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                   
                } else {
                    // TODO: Handle this error in UI
                }
            }
        }

    }
}
