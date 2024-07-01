//
//  DashboardView.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "transactionOrder", ascending: true)]) private var transactionHistory: FetchedResults<TransactionHistory>
    @State private var showingSaveMoneyView = false
    
    var dashbaordNavigation: DashbaordNavigation
    
    var body: some View {
        TabView(selection: $dashboardViewModel.currentTab) {
            GoalView()
                .tabItem {
                    Label(MMConstants.TitleText.goals, systemImage: MMConstants.ImagePaths.clipboard)
                }.tag(1)
            dashboardViewModel.getSettingsCoordinator() {
                Utilities.loggedInUserStatus.toggle()
                Utilities.authenticationStage = 1
                dashbaordNavigation.popDashboardView?()
            }.start()
                .tabItem {
                    Label(MMConstants.TitleText.settings, systemImage: MMConstants.ImagePaths.gearshape)
                }.tag(2)
        }.navigationBarBackButtonHidden(true)
         .navigationBarTitleDisplayMode(.inline)
         .navigationTitle(dashboardViewModel.getNavigationBarTitle)
         .toolbar {
             if dashboardViewModel.currentTab == 1 {
                 HStack {
                     MMUIButton(buttonType: .icon(withBackground: false), iconDetails: (MMConstants.ImagePaths.save, isSystemImage: true, size: (18, 22)), foregroundColor: AppTheme.primaryOverlayColor) {
                          showingSaveMoneyView.toggle()
                     }
                 }
             }
        }
        .sheet(isPresented: $showingSaveMoneyView) {
            SaveMoneyView(showingSaveMoneyView: $showingSaveMoneyView, applyAdaptiveKeyboard: false)
        }
        .onAppear() {
            if Utilities.userAuthenticatioinEnabled {
                dashboardViewModel.authenticateUserLocally() {
                    if $0 {
                       
                    } else {
                        // TODO: Handle this error in UI
                    }
                }
            }
        }
    }
}

