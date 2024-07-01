//
//  Constants.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 28/11/21.
//

import Foundation

struct MMConstants {
    static var emptyString = ""
    static var mobileNumberCount = 10
    static var emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static var emailPredicate = "SELF MATCHES %@"
    static var localizedReason = "To access the secure data."
    static var unknownError = "Something went wrong, please try again later."
    static var authUserCancel = "The user did cancel."
    static var authuUserFallBack = "The user chose to use the fallback."
    static var authSystemCancel = "Authentication was cancelled by the system."
    static var authPasscodeNotSet = "Passcode is not set on the device"
    static var authNotInteractive = "User not interactive."
    static var authInvalidContext = "The context is invalid."
    static var authAppCancel = "Authentication was cancelled by application."
    static var authFailed = "The user failed to provide valid credentials"
    static var dummyVariable = MMConstants.emptyString
    static var adminContactNumber = "+919941445471"
    static var appVersion = "App Version: 1.0.0"
}

/// Image paths (both system image and assets)
extension MMConstants {
    struct ImagePaths {
        static var person = "person.circle"
        static var emptyGoals = "empty_goals"
        static var rightArrow = "arrow.right"
        static var checkedBox = "checkmark.square.fill"
        static var unCheckedBox = "square"
        static var rupees = "indianrupeesign"
        static var trash = "trash"
        static var save = "square.and.arrow.down"
        static var creditCard = "creditcard"
        static var ruppesCircle = "indianrupeesign.circle.fill"
        static var house = "house"
        static var clipboard = "list.bullet.clipboard"
        static var gearshape = "gearshape"
        static var lock = "lock"
        static var clock = "deskclock"
        static var personWave = "person.wave.2"
        static var info = "info.square"
        static var logout = "ipad.and.arrow.forward"
        static var chevronRight = "chevron.right"
        static var ecllipse = "ecllipse"
        static var onboardingOne = "onboarding_1"
        static var onboardingTwo = "onboarding_2"
        static var onboardingThree = "onboarding_3"
        static var mobileSkeleton = "mobile_skeleton"
        static var phoneCall = "phone.fill"
    }
}

/// Title text for label, textfields, buttons etc.
extension MMConstants {
    struct TitleText {
        static var totalSavings = "Total Savings"
        static var emptyInprogressGoalsTitle = "No In Progress Goals"
        static var emptyCompletedGoalsTitle = "No Completed Goals"
        static var emptyInprogressGoalsDescription = "Your in progress goal list is empty, please add some."
        static var emptyCompletedGoalsTitleDescription = "Your completed goal list is empty, please save more money to unlock a Goal."
        static var savingAmountInfo = "Amount you saving will be shared equally with all your goals."
        static var unlockedGoal = "Congratulations! You have unlocked this Goal."
        static var achievedGoal = "Congratulations! You have achieved this Goal."
        static var appAuthentication = "App Authentication"
        static var goalReminder = "Goal Reminder"
        static var enableSecurityShield = "Enable security shield"
        static var proceed = "Proceed"
        static var enableReminder = "Enable goal reminder"
        static var securityShieldDescription = "Enable app authentication and unlock your app each time using either Passcode or Biometric to securely save money against your goals."
        static var reminderDescription = "Get reminded daily as per the scheduled time so that you wont miss achieving your goal."
        static var countryCode = "+91"
        static var skip = "Skip"
        static var setGoal = "Set Goal"
        static var achieveGoal = "Achieve Goal"
        static var getStarted = "Get Started"
        static var logout = "Logout"
        static var home = "Home"
        static var remindersTitle = "Reminder"
        static var remindersSubTitle = "Enable security shield for your account"
        static var inProgress = "In Progress"
        static var helpAndSupportTitle = "Help & Support"
        static var helpAndSupportSubTitle = "Your queries & frequently asked questions"
        static var aboutTitle = "About"
        static var deleteAccount = "Delete my account"
        static var aboutSubTitle = "Terms & condition, about Maaka Money"
        static var securityTitle = "Security Shield"
        static var securitySubTitle = "Enable security shield for your acount"
        static var completed = "Completed"
        static var goals = "Goals"
        static var myGoals = "My Goals"
        static var settings = "Settings"
        static var maakaMoney = "Maaka Money"
        static var trustablePiggyBank = "Trustable piggy bank App"
        static var amountTargeted = "Amount Targeted"
        static var amountSaved = "Amount Saved"
        static var one = "1"
        static var two = "2"
        static var three = "3"
        static var zero = "0"
        static var termsAndConditions = "By proceeding, you accept Maaka Money's "
        static var mobilePlaceHolder = "9999999999"
        static var mobileCountryCode = "91+"
        static var loginHeading = "Login / Sign Up"
        static var loginSubHeading = "Money saving made easy, just enter your mobile number!"
        static var signUpHeading = "Sign up"
        static var signUpSubHeading = "Please enter the following informations"
        static var setGoalHeading = "Set goal"
        static var setGoalSubHeading = "Set your goal and start saving money towards it!"
        static var saveMoneyHeading = "Save Money"
        static var saveMoneySubHeading = "Save your money in piggy bank to achieve your goal!"
        static var otpHeading = "Security Code, please?"
        static var onboardingPrevious = "Prev"
        static var onboardingNext = "Next"
        static var otpSubHeading: String {
            set {
                dummyVariable = newValue
            }
            get {
                return "Security Code will be generated for \(dummyVariable) by admin, if you are first time user or forgot Security Code please contact admin."
            }
        }
        static var loginStepsCount: String {
            set {
              dummyVariable = newValue
            }
            get {
                return "\(dummyVariable)/\(MMConstants.TitleText.three) steps to complete"
            }
        }
        static var mobilePlaceholder = "9999999999"
        static var editNumber = "Edit Number"
        static var getOTP = "Get Security Code"
        static var name = "*  Name"
        static var sixDigitOTP = "*  6 Digit Security Code"
        static var referrerMobile = "*  Referrer Mobile"
        static var email = "*  Email"
        static var signUp = "Sign Up"
        static var goalCaption = "Caption your goal"
        static var targetedAmount = "Targeted Amount"
        static var savingAmount = "Saving Amount"
        static var done = "Done"
        static var save = "Save"
        static var cancel = "Cancel"
        static var acceptAndContinue = "Accept & Continue"
        static var reminderNotificationTitle = "Maaka Money"
        static var reminderNotificationSubTitle = "Its time to save your money!"
    }
}

/// User Default Constants
extension MMConstants {
    static var loggedInUserStatus = "user.status"
    static var loggedInUserName = "user.name"
    static var loggedInUserMobile = "user.mobile"
    static var loggedInUserEmail = "user.email"
    static var authenticationStage = "authentication.stages"
    static var initialLaunch = "initial.launch"
    static var resetAuthenticationFlow = "reset.authentication.flow"
    static var reminderEnabled = "reminder.enabled"
    static var userAuthenticatioinEnabled = "user.authentication.enabled"
    static var authenticateUserLocally = "authenticate.user.locally"
    static var availableAmount = "available.amount"
    static var transactionOrder = "transaction.order"
}

/// Alert Constants
extension MMConstants {
    static var addingMoneySucceeded: String {
        set {
            dummyVariable = newValue
        }
        get {
            return "Rs.\(dummyVariable) added to the account and will be shared equally with all the Goals."
        }
    }
    static var addingMoneyFailed = "Something went wrong on adding amount to your account. Please try again later."
    static var goalCriteriaOne = "Goal cannot be created as already you have enought amount in your account to achieve this Goal."
    static var goalCreated = "Your Goal Created"
    static var invalidTargetAmount = "Invalid Target Amount"
    static var createMoreGoal = "Do you want to add more goals?"
    static var yes = "YES"
    static var no = "NO"
    static var ok = "OK"
    static var achieveGoalFailed = "Unable to achieve your Goal currently please try again later."
    static var achieveGoal = "Achieve Goal"
    static var saveMoney = "Save Money"
    static var invalid = "Invalid"
    static var networkError = "Network Error"
    static var invalidSecurityCodeMessage = "Security code you have entered is invalid, please try again."
    static var securityShield = "Security Shield"
    static var securityShieldFailed = "Unable to enable security shield, please enable password or biometric in your device and try again."
    static var logoutUserTitle = "Log out"
    static var logoutUserMessage = "Are you want to log out of your account?"
    static var deleteUserTitle = "Delete"
    static var deleteUserMessage = "Are you want to delete your account?"
}

/// Local push notification identifiers
extension MMConstants {
    static var reminderNotificationIdentifier = "reminder.local.push.notification"
}

/// Firestore database and table names
extension MMConstants {
    struct FirestoreConstants {
        static var userCollection = "users"
    }
}
