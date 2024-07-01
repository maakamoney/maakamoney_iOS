//
//  HelpAndSupport.swift
//  MaakanMoney
//
//  Created by Anand M on 09/04/24.
//

import SwiftUI

struct HelpAndSupportView: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        let faq = settingsViewModel.getAppFaq()
        return List(faq, children: \.subList) { faq in
            Text(faq.ansOrQuestion).font(faq.contentType == .question ? .headline : .subheadline).padding(.leading, faq.contentType == .question ? 0 : -20)
        }.navigationTitle(MMConstants.TitleText.helpAndSupportTitle)
         .listStyle(.plain)
         .tint(.gray)
    }
}

