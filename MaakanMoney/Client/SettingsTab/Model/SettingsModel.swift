//
//  SettingsModel.swift
//  MaakanMoney
//
//  Created by Anand M on 10/04/24.
//

import Foundation

struct FaqList: Codable {
    let faq: [Faq]
}

struct Faq: Codable {
    let id: String
    let question: String
    let answer: String
}

struct ExpandableFaqList: Identifiable {
    var id: UUID = UUID()
    var contentType: FAQType
    var ansOrQuestion: String
    var subList: [ExpandableFaqList]?
}

