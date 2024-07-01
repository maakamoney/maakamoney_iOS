//
//  Enums.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 28/11/21.
//

import Foundation
import SwiftUI

enum OTPFocusedState {
    case otpOne
    case otpTwo
    case otpThree
    case otpFour
}

enum AuthenticationStages: Int {
    case onBoarding = 0
    case getMobileNumber = 1
    case getOTP = 2
    case signUp = 3
    case setGoals = 4
}

enum UserType {
    case admin
    case client
}

enum AuthCoordinatorEvents {
    case start
    case showLogin
}

enum DashboardCoordinatorEvents {
    case start
}

enum SettingsCoordinatorEvents {
    case start
    case showSecurityShield
    case showReminders
    case showHelpAndSupport
    case showAbout
}

enum GoalStatus {
    case inProgress
    case completed
}

enum FAQType {
    case answer
    case question
}

enum TransactionType: Int {
    case withdraw = 0
    case deposite = 1
}

enum AlertTypes {
    case userLogout
    case userAccountDeletion
}

enum CoreDataPredicates {
    
    case fetchCompletedGoals
    case fetchProgressGoals
    
    func getPredicate() -> NSPredicate {
        switch self {
        case .fetchProgressGoals:
            return NSPredicate(format: "goalCompletionStatus == %@", NSNumber(value: false))
        case .fetchCompletedGoals:
            return NSPredicate(format: "goalCompletionStatus == %@ && goalUsageStatus == %@", NSNumber(value: true), NSNumber(value: false))
        }
    }
}
