//
//  MMUIExtensions.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import Foundation
import SwiftUI

extension Image {
    init(isSystemImage: Bool, iconPath: String) {
        if isSystemImage {
            self.init(systemName: iconPath)
        } else {
            self.init(iconPath)
        }
    }
}
