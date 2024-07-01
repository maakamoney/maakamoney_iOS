//
//  SetGoalViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 11/05/24.
//

import Foundation

class SetGoalViewModel: ObservableObject {
    
    @Published var targetedAmount: String = MMConstants.emptyString
    @Published var goalCaption: String = MMConstants.emptyString
    
    var coreDataManager: CoreDataManager!
    
    func getMandatoryFieldStatus() ->Bool {
        targetedAmount.isEmpty || goalCaption.isEmpty
    }
}
