//
//  TermsAndCondition.swift
//  MaakanMoney
//
//  Created by Anand M on 13/04/24.
//

import SwiftUI

struct TermsAndConditionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var isFromLogin: Bool = true
    var termsAndConditionViewModel: TermsAndConditionViewModel = TermsAndConditionViewModel()
    
    var body: some View {
        VStack {
            List(termsAndConditionViewModel.getTermsAndCondition()?.termsAndCondition ?? [], id: \.id) { termsAndCondition in
                VStack(alignment: .leading, spacing: 10) {
                    Text(termsAndCondition.title).font(.headline)
                    Text(termsAndCondition.description).font(.subheadline)
                }.listRowSeparator(.hidden)
            }
            if isFromLogin {
                ZStack {
                    Rectangle().foregroundColor(AppTheme.primaryColor)
                    MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.acceptAndContinue) {
                        presentationMode.wrappedValue.dismiss()
                    }.padding().padding(.bottom, 40)
                }.fixedSize(horizontal: false, vertical: true)
            }
        }.navigationTitle(MMConstants.TitleText.aboutTitle)
         .listStyle(.plain)
         .padding(.top, isFromLogin ? 20 : 0)
         .optionalSafeArea(applySafeArea: isFromLogin)
    }
}

struct TermsAndCondition_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionView()
    }
}
