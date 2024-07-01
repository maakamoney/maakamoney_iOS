//
//  ColorCode.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 28/11/21.
//

import Foundation

enum ColorCode {
    case primary
    case secondary
    case background
    case surface
    case error
    case onBackground
    case onSurface
    case onPrimary
    case onSecondary
    case onError
    
    func getColorCode() -> Int {
        switch self{
        case .primary:
            return 0x0D2048
        case .secondary:
            return 0x4D88BA
        case .background:
            return 0xECECEC
        case .surface:
            return 0xFFFFFF
        case .error:
            return 0xF44336
        case .onBackground:
            return 0x004D40
        case .onSurface:
            return 0x004D40
        case .onPrimary:
            return 0xFFFFFF
        case .onSecondary:
            return 0x1B5E20
        case .onError:
            return 0xFFFFFF
        }
    }
}
