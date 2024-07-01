//
//  EnvironmentValues.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import Foundation
import SwiftUI

struct LoginMobileEK: EnvironmentKey {
    static var defaultValue: String = MMConstants.emptyString
}

struct AuthenticationNavigationEK: EnvironmentKey {
    static var defaultValue: AuthenticationNavigation? = nil
}

extension EnvironmentValues {
    var mobile: String {
        get { self[LoginMobileEK.self] }
        set { self[LoginMobileEK.self] = newValue }
    }
}
