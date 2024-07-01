//
//  SettingsView.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject private var firebaseDataManager: FirebaseDataManager
    
    var settingsNavigation: SettingsNavigation
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {   
                    HStack {
                        Image(systemName: MMConstants.ImagePaths.person).resizable().frame(width: 50, height: 50)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Utilities.loggedInUserName).font(.headline)
                            Text(MMConstants.TitleText.countryCode + Utilities.loggedInUserMobile).font(.subheadline)
                        }.padding(.vertical,2).padding(.horizontal, 10)
                        Spacer()
                    }
                }.listRowInsets(.init(top: 10, leading: 20, bottom: 10, trailing: -4))
                
                Section {
                    ForEach(settingsViewModel.settingsOptions, id: \.title) { settings in
                        HStack {
                            Image(systemName: settings.icon)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(settings.title).font(.subheadline)
                                Text(settings.subtitle).font(.caption).foregroundColor(.gray)
                            }.padding(.vertical,2).padding(.horizontal, 10)
                            Spacer()
                            MMUIButton(buttonType: .icon(withBackground: false), iconDetails: (iconDetails: MMConstants.ImagePaths.chevronRight, isSystemImage: true, size: (8, 14)), foregroundColor: .black) {
                                appCoordinator.currentViewModel = settingsViewModel
                                appCoordinator.navigationPath.append(settingsViewModel.getCoordinator(title: settings.title))
                            }
                        }
                    }.listRowSeparator(.hidden)
                }.listRowInsets(.init(top: 10, leading: 20, bottom: 10, trailing: -4))
                
                Section {
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: MMConstants.ImagePaths.logout).foregroundColor(AppTheme.errorColor)
                            MMUIButton(buttonType: .label,title: MMConstants.TitleText.logout, foregroundColor: AppTheme.errorColor) {
                                settingsViewModel.alertType = .userLogout
                                settingsViewModel.alertMessageDetails = (title: MMConstants.logoutUserTitle, message : MMConstants.logoutUserMessage)
                            }
                            Spacer()
                        }.buttonStyle(.plain)
                        HStack {
                            Image(systemName: MMConstants.ImagePaths.trash).foregroundColor(AppTheme.errorColor)
                            MMUIButton(buttonType: .label,title: MMConstants.TitleText.deleteAccount, foregroundColor: AppTheme.errorColor) {
                                settingsViewModel.alertType = .userAccountDeletion
                                settingsViewModel.alertMessageDetails = (title: MMConstants.deleteUserTitle, message : MMConstants.deleteUserMessage)
                            }
                            Spacer()
                        }.buttonStyle(.plain)
                    }
                }
            }
            VStack(alignment: .center) {
                Text(MMConstants.appVersion).foregroundColor(.gray).font(.caption)
            }.padding()
        }.alert(isPresented: $settingsViewModel.showAlertDialog) {
            Alert(title: Text(settingsViewModel.alertMessageDetails.title), message: Text(settingsViewModel.alertMessageDetails.message), primaryButton: .default(Text(MMConstants.yes), action: {
                switch settingsViewModel.alertType {
                case .userAccountDeletion:
                    Task {
                        let result = await firebaseDataManager.deleteUser(mobile: Utilities.loggedInUserMobile)
                        switch result {
                        case .success(let isDeletionSuccess):
                            settingsNavigation.popDashboardView?()
                        case .failure(_):
                            settingsViewModel.alertMessageDetails = (MMConstants.networkError, MMConstants.unknownError)
                        }
                    }
                case .userLogout:
                    settingsNavigation.popDashboardView?()
                }
            }), secondaryButton: .cancel(Text(MMConstants.no)))
         }
         .environmentObject(settingsViewModel)
         .background(.white)
    }
}

