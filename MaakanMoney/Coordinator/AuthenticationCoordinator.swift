//
//  AuthCoordinator.swift
//  MaakanMoney
//
//  Created by Anand M on 28/03/24.
//

import Foundation
import SwiftUI

final class AuthCoordinator: Hashable {
    
    var id: UUID
    var event:  AuthCoordinatorEvents
    var appNavigation: AppNavigation
    
    static var sharedAuthCoordinator = AuthCoordinator()

    private init(event: AuthCoordinatorEvents = .start, appNavigation: AppNavigation = AppNavigation()) {
        id = UUID()
        self.event = event
        self.appNavigation = appNavigation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AuthCoordinator, rhs: AuthCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func onboardingView() -> some View  {
        let authCoordinator = AuthCoordinator.sharedAuthCoordinator
        return OnBoarding(authenticationNavigation: .init(pushLoginView: { appNavigationPath in
            appNavigationPath.wrappedValue.append(authCoordinator)
        }))
    }
    
    func loginView() -> some View {
        LoginView(authenticationNavigation: .init(pushDashboardView: {
            self.appNavigation.pushDashboardView?()
        }))
    }
    @ViewBuilder
    func getViewForEvent() -> some View {
        switch event {
        case .start:
            onboardingView()
        case .showLogin:
            loginView()
        }
    }
}

struct AuthenticationNavigation {
    var pushLoginView: AppNavigationPath?
    var pushDashboardView: (() -> ())?
}
