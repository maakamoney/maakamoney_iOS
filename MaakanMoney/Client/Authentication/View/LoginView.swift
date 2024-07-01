//
//  LoginView.swift
//  MaakanMoney
//
//  Created by Anand M on 20/02/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @FocusState var currentFocusedField: FocusedField?
    
    var authenticationNavigation: AuthenticationNavigation
  
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle().fill(AppTheme.primaryColor)
                VStack {
                    Spacer()
                    Text(authenticationViewModel.getStepCount()).font(.caption).foregroundColor(AppTheme.primaryOverlayColor)
                    VStack {
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 20).foregroundColor(AppTheme.primaryOverlayColor).shadow(color: Color.black.opacity(0.10), radius: 10)
                            if authenticationViewModel.authenticationStages == .setGoals {
                                HStack {
                                    Spacer()
                                    MMUIButton(buttonType: .label,title: MMConstants.TitleText.skip, foregroundColor: AppTheme.primaryColor) {
                                        Utilities.loggedInUserStatus.toggle()
                                        authenticationNavigation.pushDashboardView?()
                                    }
                                }.padding(.vertical, 5).padding(.horizontal)
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Text(authenticationViewModel.getHeadingAndSubHeading().0).font(.title3).bold().padding(.horizontal)
                                Text(authenticationViewModel.getHeadingAndSubHeading().1).font(.caption).padding(.horizontal)
                                TabView(selection: $authenticationViewModel.authenticationStages) {
                                    GetMobileNumberView(authenticationViewModel: authenticationViewModel, bottomSheetHeight: $authenticationViewModel.bottomSheetHeight, currentFocusedField: _currentFocusedField).padding(.horizontal).tag(AuthenticationStages.getMobileNumber)
                                    GetOTPView(authenticationViewModel: authenticationViewModel, currentFocusedField: _currentFocusedField, bottomSheetHeight: $authenticationViewModel.bottomSheetHeight, authenticationNavigation: authenticationNavigation).tag(AuthenticationStages.getOTP)
                                    SignUpView(authenticationViewModel: authenticationViewModel, currentFocusedField: _currentFocusedField).tag(AuthenticationStages.signUp)
                                    SetGoalsView(applyAdaptiveKeyboard: true).tag(AuthenticationStages.setGoals)
                                }.tabViewStyle(.page(indexDisplayMode: .never))
                                 .onAppear() {
                                    UIScrollView.appearance().isScrollEnabled = false
                                 }
                            }.padding(.vertical, 20)
                        }
                    }.frame(height: geometry.size.height * authenticationViewModel.bottomSheetHeight)
                }
            }
        }.navigationBarBackButtonHidden(true)
         .edgesIgnoringSafeArea(.all)
         .onAppear() {
             authenticationViewModel.resetAuthenticationStage()
             switch authenticationViewModel.authenticationStages {
             case .getMobileNumber, .onBoarding:
                 currentFocusedField = .mobileNumber
             case .getOTP:
                 currentFocusedField = .otp
             case .signUp:
                 currentFocusedField = .name
             case .setGoals:
                 currentFocusedField = .goalAmount
             }
        }
    }
}


