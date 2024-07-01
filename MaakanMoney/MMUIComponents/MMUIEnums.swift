//
//  MMUIEnums.swift
//  MaakanMoney
//
//  Created by Anand M on 10/03/24.
//

import Foundation
import SwiftUI

enum MMUITextFieldTypes: Equatable {
    case defaultStyle
    case singleCharacter
    case withSeparator
    case backgroundColor(Color)
}

indirect enum MMUIButtonTypes: Equatable {
    case defaultStyle(fixedSize: Bool, withIcon: Bool, buttonType: MMUIButtonTypes)
    case icon(withBackground: Bool)
    case capsule
    case roundedCorner
    case label
    case bordered
}

