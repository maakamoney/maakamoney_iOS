//
//  MaakanMoneyApp.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 28/11/21.
//

import SwiftUI

@main
struct MaakanMoneyApp: App {
    
    @StateObject private var appCoordinator = AppCoordinator(navigationPath: NavigationPath())
    @StateObject private var coreDataManager: CoreDataManager = CoreDataManager()
    @StateObject private var firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITabBar.appearance().backgroundColor = UIColor(AppTheme.primaryColor)
        UITabBar.appearance().unselectedItemTintColor = UIColor(AppTheme.primaryOverlayColor.opacity(0.5))
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().backgroundColor = UIColor(AppTheme.secondaryColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(AppTheme.secondaryColor)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(AppTheme.primaryOverlayColor)], for: .normal)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.navigationPath) {
                VStack {
                    if appCoordinator.refreshInitialView {
                        appCoordinator.start()
                    }
                }.navigationDestination(for: AuthCoordinator.self) { coordinator in
                    coordinator.getViewForEvent()
                }
                .navigationDestination(for: DashboardCoordinator.self) { coordinator in
                    coordinator.getViewForEvent()
                }
                .navigationDestination(for: SettingsCoordinator.self) { coordinator in
                    if let currenViewModel = appCoordinator.currentViewModel as? SettingsViewModel {
                        coordinator.getViewForEvent(viewModel: currenViewModel)
                    }
                }
            }.environmentObject(appCoordinator)
             .environmentObject(coreDataManager)
             .environmentObject(firebaseDataManager)
             .environment(\.managedObjectContext, coreDataManager.container.viewContext)
             .navigationBarColor(backgroundColor: UIColor(AppTheme.primaryColor), tintColor: .white)
             .preferredColorScheme(.light)
        }
    }
}
