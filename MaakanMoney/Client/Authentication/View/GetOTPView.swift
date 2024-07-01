//
//  GetOTPView.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseCore

struct GetOTPView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject private var firebaseDataManager: FirebaseDataManager
    @FocusState var currentFocusedField: FocusedField?
    @State private var proceedToSignUp: Bool = false
    @Binding var bottomSheetHeight: CGFloat
    
    var authenticationNavigation: AuthenticationNavigation
    
    var body: some View {
        VStack {
            MMUITextField(value: $authenticationViewModel.otp, placeHolder: MMConstants.TitleText.sixDigitOTP, fontDetails: (size: 18, weight: .regular), keyboardType: .numberPad, textFieldType: .defaultStyle, textLimit: 6).focused($currentFocusedField, equals: .otp).padding()
            MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.proceed, isLoading: $authenticationViewModel.isLoading) {
                Task {
                    authenticationViewModel.isLoading.toggle()
                    let result = await firebaseDataManager.validateMobile(mobile: Utilities.loggedInUserMobile)
                    authenticationViewModel.isLoading.toggle()
                    switch result {
                    case .success(let querySnapshot):
                        handleUserQuerySnapshot(querySnapshot:  querySnapshot)
                    case .failure(_):
                        authenticationViewModel.alertMessageDetails = (MMConstants.networkError, MMConstants.unknownError)
                    }
                }
            }.padding(.horizontal)
            .disabled(!proceedToSignUp).opacity(proceedToSignUp ? 1 : 0.5)
            HStack {
                MMUIButton(buttonType: .defaultStyle(fixedSize: true, withIcon: true, buttonType: .label),title: MMConstants.TitleText.getOTP, iconDetails: (iconDetails: MMConstants.ImagePaths.phoneCall, isSystemImage: true, size: (12, 12)), foregroundColor: AppTheme.primaryColor) {
                    callAdminForOTP(phoneNumber: MMConstants.adminContactNumber)
                }
                Spacer()
                // TODO: Change this native button to MMButton
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        bottomSheetHeight = 0.65
                    }
                    authenticationViewModel.authenticationStages = .getMobileNumber
                } label: {
                    Text(MMConstants.TitleText.editNumber).font(.system(size: 14, weight: .medium)).foregroundColor(AppTheme.primaryColor)
                }.padding(.trailing)
            }
            Spacer()
        }.onChange(of: authenticationViewModel.otp) { newValue in
            proceedToSignUp = authenticationViewModel.otp.count == 6 ? true : false
        }
        .alert(isPresented: $authenticationViewModel.showUserVerificationStatusAlert) {
            Alert(title: Text(MMConstants.invalid), message: Text(MMConstants.invalidSecurityCodeMessage), dismissButton: .default(Text(MMConstants.ok)) {})
        }
    }
    
    func callAdminForOTP(phoneNumber: String) {
        if let url = URL(string: "tel://" + phoneNumber), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func pushDashboardView() {
        Utilities.loggedInUserStatus.toggle()
        authenticationNavigation.pushDashboardView?()
    }
    
    func pushSignupView() {
        withAnimation {
            authenticationViewModel.authenticationStages = .signUp
        }
        Utilities.authenticationStage = 3
        currentFocusedField = .name
    }
    
    func handleUserQuerySnapshot(querySnapshot: Any) {
        guard let userQuerySnapshot = querySnapshot as? QuerySnapshot else { return }
        authenticationViewModel.userQuerySnapshot = userQuerySnapshot
        if authenticationViewModel.validateSecurityCode(userInputSecurityCode: authenticationViewModel.otp) {
            authenticationViewModel.validateSignUpCompletion() ? pushDashboardView() : pushSignupView()
            authenticationViewModel.updateUserData()
        } else {
            authenticationViewModel.alertMessageDetails = (MMConstants.invalid, MMConstants.invalidSecurityCodeMessage)
        }
    }
}

