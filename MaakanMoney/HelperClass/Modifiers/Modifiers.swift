//
//  Modifiers.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 03/12/21.
//

import SwiftUI
import Combine

struct NavigationBarColor: ViewModifier {
    
    init(backgroundColor: UIColor, tintColor: UIColor) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().standardAppearance.shadowColor = .clear
    }
    
    func body(content: Content) -> some View {
        content
    }
}

struct KeyboardAdaptive: ViewModifier {
    
    @State private var bottomPadding: CGFloat = 0
    var applyAdaptiveKeyboard: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    withAnimation {
                        if applyAdaptiveKeyboard {
                            bottomPadding = keyboardHeight - (keyboardHeight == 0 ? 0 : 50)
                        }
                    }
                }
        }
    }
}

struct OptionalSafeArea: ViewModifier {
    
    var applySafeArea: Bool = false
    
    func body(content: Content) -> some View {
        if applySafeArea {
            content.edgesIgnoringSafeArea(.bottom)
        } else {
            content
        }
    }
}
