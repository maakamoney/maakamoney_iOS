//
//  Utilities.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 17/12/21.
//

import Foundation

// MARK: - Utilities for date formatter
class Utilities{
    static func getFormattedDate(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let selectedDate = dateFormatter.string(from: date).split(separator: " ")[1].dropLast()
        let selectedMonth = dateFormatter.string(from: date).split(separator: " ")[0]
        let selectedYear = dateFormatter.string(from: date).split(separator: " ")[2].suffix(2)
        
        return selectedDate + " " + selectedMonth + " " + selectedYear
    }
}
// MARK: - Utilities for user default
extension Utilities {
    static var userDefault = UserDefaults.standard
    static var loggedInUserStatus: Bool {
        get {
            if let status = userDefault.value(forKey: MMConstants.loggedInUserStatus) as? Bool {
                return status
            }
            return false
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.loggedInUserStatus)
        }
    }
    
    static var loggedInUserMobile: String {
        get {
            if let status = userDefault.value(forKey: MMConstants.loggedInUserMobile) as? String {
                return status
            }
            return MMConstants.emptyString
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.loggedInUserMobile)
        }
    }
    
    static var loggedInUserEmail: String {
        get {
            if let status = userDefault.value(forKey: MMConstants.loggedInUserEmail) as? String {
                return status
            }
            return MMConstants.emptyString
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.loggedInUserEmail)
        }
    }
    
    static var loggedInUserName: String {
        get {
            if let status = userDefault.value(forKey: MMConstants.loggedInUserName) as? String {
                return status
            }
            return MMConstants.emptyString
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.loggedInUserName)
        }
    }
    
    static var authenticationStage: Int {
        get {
            if let status = userDefault.value(forKey: MMConstants.authenticationStage) as? Int {
                return status
            }
            return 0
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.authenticationStage)
        }
    }
    
    static var resetAuthenticationFlow: Bool {
        get {
            if let status = userDefault.value(forKey: MMConstants.resetAuthenticationFlow) as? Bool {
                return status
            }
            return false
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.resetAuthenticationFlow)
        }
    }
    
    static var reminderEnabled: Bool {
        get {
            if let status = userDefault.value(forKey: MMConstants.reminderEnabled) as? Bool {
                return status
            }
            return false
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.reminderEnabled)
        }
    }
    
    static var userAuthenticatioinEnabled: Bool {
        get {
            if let status = userDefault.value(forKey: MMConstants.userAuthenticatioinEnabled) as? Bool {
                return status
            }
            return false
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.userAuthenticatioinEnabled)
        }
    }
    
    static var availableAmount: Int64 {
        get {
            if let status = userDefault.value(forKey: MMConstants.availableAmount) as? Int64 {
                return status
            }
            return 0
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.availableAmount)
        }
    }
    
    static var transactionOrder: Int16 {
        get {
            if let status = userDefault.value(forKey: MMConstants.transactionOrder) as? Int16 {
                return status
            }
            return 0
        }
        set(newStatus) {
            userDefault.setValue(newStatus, forKey: MMConstants.transactionOrder)
        }
    }
}
