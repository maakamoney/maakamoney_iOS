//
//  SettingsViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import Foundation
import LocalAuthentication
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    //MARK: Observable Properties
    @Published var showAlertDialog = false
    
    //MARK: Stored Properties
    var dateComponents = DateComponents()
    var userAuthError: NSError?
    var alertType: AlertTypes = .userLogout
    let content = UNMutableNotificationContent()
    let notificationCenter = UNUserNotificationCenter.current()
    let localAuthenticationContext = LAContext()
    
    
    var settingsOptions = [(title: MMConstants.TitleText.securityTitle, subtitle: MMConstants.TitleText.securitySubTitle, icon: MMConstants.ImagePaths.lock), (title: MMConstants.TitleText.remindersTitle, subtitle: MMConstants.TitleText.remindersSubTitle, icon: MMConstants.ImagePaths.clock), (title: MMConstants.TitleText.helpAndSupportTitle, subtitle: MMConstants.TitleText.helpAndSupportSubTitle, icon: MMConstants.ImagePaths.personWave), (title: MMConstants.TitleText.aboutTitle, subtitle: MMConstants.TitleText.aboutSubTitle, icon: MMConstants.ImagePaths.info)]
    
    //MARK: Computed Properties
    var alertMessageDetails: (title: String, message: String) = (title: MMConstants.emptyString, message: MMConstants.emptyString) {
        didSet {
            showAlertDialog.toggle()
        }
    }
    
    func getAppFaq() -> [ExpandableFaqList] {
        let decoder = JSONDecoder()
        var expandableFaqList = [ExpandableFaqList]()
        guard
            let url = Bundle.main.url(forResource: "FAQ", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decodedFaq = try? decoder.decode(FaqList.self, from: data)
        else { return [] }
        for faq in decodedFaq.faq {
            let expandableFaq = ExpandableFaqList(contentType: .question, ansOrQuestion: faq.question, subList: [ExpandableFaqList(contentType: .answer, ansOrQuestion: faq.answer)])
            expandableFaqList.append(expandableFaq)
        }
        return expandableFaqList
    }
    
    func getCoordinator(title: String) -> SettingsCoordinator {
        let settingsCoordinator = SettingsCoordinator.sharedSettingsCoordinator
        switch title {
        case MMConstants.TitleText.securityTitle:
            settingsCoordinator.event = .showSecurityShield
        case MMConstants.TitleText.remindersTitle:
            settingsCoordinator.event = .showReminders
        case MMConstants.TitleText.helpAndSupportTitle:
            settingsCoordinator.event = .showHelpAndSupport
        case MMConstants.TitleText.aboutTitle:
            settingsCoordinator.event = .showAbout
        default:
            settingsCoordinator.event = .start
        }
        return settingsCoordinator
    }
    
    func getLocalNotificationPermission(result: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            result(success, error)
        }
    }
    
    func scheduleLocalNotification() {
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 10
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        content.title = MMConstants.TitleText.reminderNotificationTitle
        content.subtitle = MMConstants.TitleText.reminderNotificationSubTitle
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: MMConstants.reminderNotificationIdentifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error {
                // TODO: Handle this error in UI
                print(error.localizedDescription)
            }
       }
    }
    
    func cancelLocalNotification() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [MMConstants.reminderNotificationIdentifier])
    }
    
    func handleNotificationAccessStatus() {
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                self.scheduleLocalNotification()
            case .denied:
                // TODO: Handle this error in UI
                print("Enable notification permission in settings")
            case .notDetermined:
                self.getLocalNotificationPermission { result, error in
                    if result {
                        self.scheduleLocalNotification()
                    } else if let error {
                        // TODO: Handle this error in UI
                        print(error.localizedDescription)
                    }
                }
            default:
                // TODO: Handle this error in UI
                print(MMConstants.unknownError)
            }
        }
    }
    
    func requestTouchIDAuthentication(isSuccess: (Bool) -> Void) {
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &userAuthError) {
            isSuccess(true)
        } else {
            guard userAuthError != nil else {
                return
            }
            isSuccess(false)
        }
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var errorMessage = MMConstants.emptyString
        
        switch errorCode {
        case LAError.authenticationFailed.rawValue:
            errorMessage = MMConstants.authFailed
        case LAError.appCancel.rawValue:
            errorMessage = MMConstants.authAppCancel
        case LAError.invalidContext.rawValue:
            errorMessage = MMConstants.authInvalidContext
        case LAError.notInteractive.rawValue:
            errorMessage = MMConstants.authNotInteractive
        case LAError.passcodeNotSet.rawValue:
            errorMessage = MMConstants.authPasscodeNotSet
        case LAError.systemCancel.rawValue:
            errorMessage = MMConstants.authSystemCancel
        case LAError.userCancel.rawValue:
            errorMessage = MMConstants.authUserCancel
        case LAError.userFallback.rawValue:
            errorMessage = MMConstants.authuUserFallBack
        default:
            errorMessage = MMConstants.unknownError
        }
        return errorMessage
    }
}

extension SettingsViewModel: CurrentViewModel {}
