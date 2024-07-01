//
//  SecurityShieldView.swift
//  MaakanMoney
//
//  Created by Anand M on 09/04/24.
//

import SwiftUI

struct SecurityShieldView: View {
    
    @State private var enableSecurityShield =  Utilities.userAuthenticatioinEnabled
    @State private var showSecurityShieldStatusAlert = false
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        List {
            Section(header: Text(MMConstants.TitleText.appAuthentication).padding(.vertical,4)) {
                Toggle(MMConstants.TitleText.enableSecurityShield, isOn: $enableSecurityShield)
               
            }
            Text(MMConstants.TitleText.securityShieldDescription).listRowBackground(Color.clear).foregroundColor(.gray).font(.subheadline).padding(.top, -10)
        }
        .onChange(of: enableSecurityShield) { enableReminderStatus in
            if enableSecurityShield {
                settingsViewModel.requestTouchIDAuthentication() {
                    if !$0 {
                        showSecurityShieldStatusAlert.toggle()
                        Utilities.userAuthenticatioinEnabled = false
                    } else {
                        Utilities.userAuthenticatioinEnabled = enableSecurityShield
                    }
                }
            } else {
                Utilities.userAuthenticatioinEnabled = false
            }
        }
        .alert(isPresented: $showSecurityShieldStatusAlert) {
            Alert(title: Text(MMConstants.securityShield), message: Text(MMConstants.securityShieldFailed), dismissButton: .default(Text(MMConstants.ok)) {
                enableSecurityShield = false
            })
        }
        .navigationTitle(MMConstants.TitleText.securityTitle)
    }
}
