//
//  GetMobileNumberView.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import SwiftUI

struct GetMobileNumberView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject private var firebaseDataManager: FirebaseDataManager
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var isHidden: Bool = false
    @State private var proccedToOTP: Bool = false
    @State private var presentTermsAndCondition: Bool = false
    @Binding var bottomSheetHeight: CGFloat
    @FocusState var currentFocusedField: FocusedField?
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                MMUITextField(value: $authenticationViewModel.mobile, placeHolder: MMConstants.TitleText.mobilePlaceholder, keyboardType: .numberPad, textFieldType: .withSeparator, textLimit: 10).focused($currentFocusedField, equals: .mobileNumber)
                MMUIButton(buttonType: .icon(withBackground: true), iconDetails: (iconDetails: MMConstants.ImagePaths.rightArrow, isSystemImage: true, size: (20, 18))) {
                    withAnimation(.linear(duration: 0.2)) { bottomSheetHeight = 0.90 }
                    authenticationViewModel.authenticationStages = .getOTP
                    Utilities.loggedInUserMobile = authenticationViewModel.mobile
                    currentFocusedField = .otp
                }.disabled(!proccedToOTP).opacity(proccedToOTP ? 1 : 0.5)
            }.padding(.vertical,30)
                .opacity(isHidden ? 0 : 1)
            HStack {
                MMUIButton(buttonType: .icon(withBackground: false), iconDetails: (iconDetails: authenticationViewModel.termsAndCondition ? MMConstants.ImagePaths.checkedBox : MMConstants.ImagePaths.unCheckedBox, isSystemImage: true, size: (16, 16)), foregroundColor: AppTheme.primaryColor) {
                    authenticationViewModel.termsAndCondition.toggle()
                }
                VStack(alignment: .leading) {
                    Text(MMConstants.TitleText.termsAndConditions).font(.caption).foregroundColor(AppTheme.primaryColor)
                    Button {
                        presentTermsAndCondition.toggle()
                    } label: {
                        Text("Terms and Condition").font(.caption).foregroundColor(AppTheme.secondaryColor)
                    }
                }
                Spacer()
            }
            .padding(.leading, -10)
            .opacity(isHidden ? 0 : 1)
            Spacer()
        }.onChange(of: authenticationViewModel.mobile) { mobile in
            proccedToOTP = authenticationViewModel.proceedToOTP()
        }.onChange(of: authenticationViewModel.termsAndCondition) { termsAndCondition in
            proccedToOTP = authenticationViewModel.proceedToOTP()
        }
        .fullScreenCover(isPresented: $presentTermsAndCondition, content: TermsAndConditionView.init)
    }
}

