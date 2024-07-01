//
//  RemindersView.swift
//  MaakanMoney
//
//  Created by Anand M on 09/04/24.
//

import SwiftUI

struct RemindersView: View {
    
    @State private var enableReminder = Utilities.reminderEnabled
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        List {
            Section(header: Text(MMConstants.TitleText.goalReminder).padding(.vertical,4)) {
                Toggle(MMConstants.TitleText.enableReminder, isOn: $enableReminder)
            }
            Text(MMConstants.TitleText.reminderDescription).listRowBackground(Color.clear).foregroundColor(.gray).font(.subheadline).padding(.top, -10)
        }
        .onChange(of: enableReminder) { enableReminderStatus in
            Utilities.reminderEnabled = enableReminder
            Utilities.reminderEnabled ? settingsViewModel.handleNotificationAccessStatus() : settingsViewModel.cancelLocalNotification()
        }
        .navigationTitle(MMConstants.TitleText.remindersTitle)
    }
}

