//
//  TermsAndConditionModel.swift
//  MaakanMoney
//
//  Created by Anand M on 13/04/24.
//

import Foundation

struct TermsAndConditionList: Codable {
    let termsAndCondition: [TermsAndCondition]
}

struct TermsAndCondition: Codable {
    let id: String
    let title: String
    let description: String
}
