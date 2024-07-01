//
//  AppTheme.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import Foundation
import SwiftUI

struct AppTheme {
    static var primaryColor: Color = Color(hex: ColorCode.primary.getColorCode())
    static var secondaryColor: Color = Color(hex: ColorCode.secondary.getColorCode())
    static var primaryOverlayColor: Color = .white
    static var secondaryOverlayColor: Color = .white
    static var errorColor: Color = Color(hex: ColorCode.error.getColorCode())
    static var errorOverlayColor: Color = Color(hex: ColorCode.onError.getColorCode())
    static var clear: Color = .clear
}
