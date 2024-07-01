//
//  Extensions.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 28/11/21.
//

import Foundation
import SwiftUI
import Combine

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
        modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
    }
    
    func keyboardAdaptive(applyAdaptiveKeyboard: Bool) -> some View {
        modifier(KeyboardAdaptive(applyAdaptiveKeyboard: applyAdaptiveKeyboard))
    }
    
    func optionalSafeArea(applySafeArea: Bool) -> some View {
        modifier(OptionalSafeArea(applySafeArea: applySafeArea))
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

