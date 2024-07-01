//
//  SignUpView.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State var proceedToSetGoals: Bool = false
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject private var firebaseDataManager: FirebaseDataManager
    @FocusState var currentFocusedField: FocusedField?
    
    
    var body: some View {
        VStack(spacing: 30) {
            MMUITextField(value: $authenticationViewModel.name, placeHolder: MMConstants.TitleText.name,fontDetails: (size: 18, weight: .regular), textFieldType: .defaultStyle).focused($currentFocusedField, equals: .name)
            MMUITextField(value: Binding.constant(Utilities.loggedInUserMobile), placeHolder: MMConstants.TitleText.mobilePlaceholder,keyboardType: .numberPad, textFieldType: .withSeparator, textLimit: 10).disabled(true)
            MMUITextField(value: $authenticationViewModel.email, placeHolder: MMConstants.TitleText.email,fontDetails: (size: 18, weight: .regular), textFieldType: .defaultStyle).focused($currentFocusedField, equals: .email)
            Spacer()
            MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.signUp, isLoading: $authenticationViewModel.isLoading) {
                Task {
                    authenticationViewModel.isLoading.toggle()
                    let result = await firebaseDataManager.updateSignUpDetails(name: authenticationViewModel.name, email: authenticationViewModel.email)
                    authenticationViewModel.isLoading.toggle()
                    switch result {
                    case .success(_):
                        withAnimation {
                            authenticationViewModel.authenticationStages = .setGoals
                        }
                        Utilities.loggedInUserName = authenticationViewModel.name
                        Utilities.loggedInUserEmail = authenticationViewModel.email
                        Utilities.authenticationStage = 4
                    case .failure(_):
                        authenticationViewModel.alertMessageDetails = (MMConstants.networkError, MMConstants.unknownError)
                    }
                }
            }.disabled(!proceedToSetGoals).opacity(proceedToSetGoals ? 1 : 0.5)
        }.padding(.horizontal, 20)
         .padding(.vertical,30)
         .keyboardAdaptive(applyAdaptiveKeyboard: true)
         .onChange(of: authenticationViewModel.name) { name in
            proceedToSetGoals = authenticationViewModel.proceedToSetGoals()
         }
         .onChange(of: authenticationViewModel.email) { email in
            proceedToSetGoals = authenticationViewModel.proceedToSetGoals()
        }
    }
}
