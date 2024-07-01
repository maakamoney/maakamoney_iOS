//
//  GoalModel.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import Foundation

struct GoalInformations {
    var id: UUID = UUID()
    var goalCaption: String
    var targetedAmount: Int
    var goalStatus: GoalStatus
}

