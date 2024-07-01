//
//  AppCoordinator.swift
//  MaakanMoney
//
//  Created by Anand M on 27/03/24.
//

import Foundation
import SwiftUI

typealias AppNavigationPath = ((Binding<NavigationPath>) -> ())

final class AppCoordinator: ObservableObject {
    
    @Published var navigationPath: NavigationPath
     
    var refreshInitialView = true
    var currentViewModel: CurrentViewModel?
    
    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
        if Utilities.loggedInUserStatus {
            self.navigationPath.append(getDashboardCoordinator(appNavigation: AppNavigation(popDashboardView: {
                self.refreshInitialView = true
                self.navigationPath.removeLast()
            })))
        }
    }
    
    func start() -> some View {
        refreshInitialView = false
        return AppEntryView()
    }
    
    func getDashboardCoordinator(event: DashboardCoordinatorEvents = .start, appNavigation: AppNavigation = AppNavigation()) -> DashboardCoordinator {
        let dashboardCoordinator = DashboardCoordinator.sharedDashboardCoordinator
        dashboardCoordinator.event = event
        dashboardCoordinator.appNavigation = appNavigation
        return dashboardCoordinator
    }
    
    func getAuthCoordinator(event: AuthCoordinatorEvents = .start, appNavigation: AppNavigation = AppNavigation()) -> AuthCoordinator {
        let authCoordinator = AuthCoordinator.sharedAuthCoordinator
        authCoordinator.event = event
        authCoordinator.appNavigation = appNavigation
        return authCoordinator
    }
}

struct AppEntryView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var getEvent: AuthCoordinatorEvents {
        Utilities.authenticationStage == 0 ? .start : .showLogin
    }
    
    @ViewBuilder
    func initialView() -> some View {
        appCoordinator.getAuthCoordinator(event: getEvent, appNavigation: AppNavigation(pushDashboardView: {
            appCoordinator.navigationPath.append(appCoordinator.getDashboardCoordinator(appNavigation: AppNavigation(popDashboardView: {
                appCoordinator.refreshInitialView = true
                appCoordinator.navigationPath.removeLast()
            })))
        })).getViewForEvent()
    }

    var body: some View {
        initialView()
    }
}

struct AppNavigation {
    var popDashboardView: (() -> ())?
    var pushDashboardView: (() -> ())?
}

