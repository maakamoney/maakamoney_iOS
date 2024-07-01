//
//  TermsAndConditionViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 13/04/24.
//

import Foundation

class TermsAndConditionViewModel {
    
    func getTermsAndCondition() -> TermsAndConditionList? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: "TermsAndCondition", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decodedTermsAndCondition = try? decoder.decode(TermsAndConditionList.self, from: data)
       else { return nil }
       return decodedTermsAndCondition
    }
    
}
