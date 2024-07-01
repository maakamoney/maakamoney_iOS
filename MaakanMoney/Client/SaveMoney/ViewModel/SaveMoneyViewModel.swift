//
//  SaveMoneyViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 11/05/24.
//

import Foundation

class SaveMoneyViewModel: ObservableObject {
    
    @Published var savingAmount: String = MMConstants.emptyString
    
    func getMandatoryFieldStatus() ->Bool {
        savingAmount.isEmpty
    }
}
