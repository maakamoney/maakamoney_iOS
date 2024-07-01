//
//  AuthenticationViewModel.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 31/12/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseCore

class AuthenticationViewModel: ObservableObject {
    
    @Published var authenticationStages: AuthenticationStages = AuthenticationStages(rawValue: Utilities.authenticationStage) ?? .onBoarding
    @Published var mobile: String = MMConstants.emptyString
    @Published var otp: String = MMConstants.emptyString
    @Published var name: String = MMConstants.emptyString
    @Published var email: String = MMConstants.emptyString
    @Published var termsAndCondition: Bool = false
    @Published var bottomSheetHeight: CGFloat = Utilities.authenticationStage == 1 ? 0.65 : 0.90
    @Published var showUserVerificationStatusAlert = false
    @Published var isLoading: Bool = false
    
    
    var alertMessageDetails: (String, String) = (MMConstants.emptyString, MMConstants.emptyString) {
        didSet {
            showUserVerificationStatusAlert.toggle()
        }
    }
    
    var userQuerySnapshot: QuerySnapshot!
    
    func getStepCount() -> String {
        switch authenticationStages {
        case .getMobileNumber:
            return MMConstants.emptyString
        case .getOTP:
            MMConstants.TitleText.loginStepsCount = MMConstants.TitleText.one
            return MMConstants.TitleText.loginStepsCount
        case.signUp:
            MMConstants.TitleText.loginStepsCount = MMConstants.TitleText.two
            return MMConstants.TitleText.loginStepsCount
        case .setGoals:
            MMConstants.TitleText.loginStepsCount = MMConstants.TitleText.three
            return MMConstants.TitleText.loginStepsCount
        case .onBoarding:
            return MMConstants.emptyString
        }
    }
    
    func getHeadingAndSubHeading() -> (String, String) {
        switch authenticationStages {
        case .getMobileNumber:
            return (MMConstants.TitleText.loginHeading, MMConstants.TitleText.loginSubHeading)
        case .getOTP:
            MMConstants.TitleText.otpSubHeading = mobile
            return (MMConstants.TitleText.otpHeading, MMConstants.TitleText.otpSubHeading)
        case.signUp:
            return (MMConstants.TitleText.signUpHeading, MMConstants.TitleText.signUpSubHeading)
        case .setGoals:
            return (MMConstants.TitleText.setGoalHeading, MMConstants.TitleText.setGoalSubHeading)
        case .onBoarding:
            return (MMConstants.emptyString, MMConstants.emptyString)
        }
    }
    
    func resetAuthenticationStage() {
        authenticationStages = AuthenticationStages(rawValue: Utilities.authenticationStage) ?? .onBoarding
        bottomSheetHeight = Utilities.authenticationStage == 1 ? 0.65 : 0.90
    }
    
    func proceedToSetGoals() -> Bool {
        name !=  MMConstants.emptyString ? isValidEmail() ? true : false : false
    }
    
    func proceedToOTP() -> Bool {
        mobile.count == 10 ? termsAndCondition ? true : false : false
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = MMConstants.emailRegex
        let emailPredicate = NSPredicate(format: MMConstants.emailPredicate, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validateSecurityCode(userInputSecurityCode: String) -> Bool {
        if let securityCode = userQuerySnapshot.documents.first?.data()["securityCode"] as? Int, let userInputSecurityCode = Int(userInputSecurityCode), securityCode == userInputSecurityCode {
            return true
        }
        return false
    }
    
    func validateSignUpCompletion() -> Bool {
        userQuerySnapshot.documents.first?.data()["isVerified"] as! Bool
    }
    
    func updateUserData() {
        mobile = MMConstants.emptyString
        otp = MMConstants.emptyString
        Utilities.loggedInUserEmail = userQuerySnapshot.documents.first?.data()["email"] as? String ?? MMConstants.emptyString
        Utilities.loggedInUserName = userQuerySnapshot.documents.first?.data()["name"] as? String ?? MMConstants.emptyString
    }
}

enum FocusedField {
    case mobileNumber
    case otp
    case name
    case referrerMobile
    case email
    case goalAmount
    case goalCaption
}
