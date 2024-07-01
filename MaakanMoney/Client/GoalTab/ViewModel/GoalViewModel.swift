//
//  GoalViewModel.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import Foundation

class GoalViewModel: ObservableObject {
    
    @Published var goalStatus: GoalStatus = .inProgress
    
    var goalList: [GoalInformations] = [GoalInformations(goalCaption: "Bike", targetedAmount: 1223, goalStatus: .completed), GoalInformations(goalCaption: "Laptop", targetedAmount: 3000, goalStatus: .inProgress), GoalInformations(goalCaption: "Car", targetedAmount: 2100, goalStatus: .completed)]
    
    func getGoalList() -> [GoalInformations] {
        goalList.filter { goalDetails in
            return goalDetails.goalStatus == self.goalStatus
        }
    }
    
    func getEmptyListAlertDetails() -> (title: String, description: String) {
        goalStatus == .inProgress ? (title: MMConstants.TitleText.emptyInprogressGoalsTitle, description: MMConstants.TitleText.emptyInprogressGoalsDescription) : (title: MMConstants.TitleText.emptyCompletedGoalsTitle, description: MMConstants.TitleText.emptyCompletedGoalsTitleDescription)
    }
    
    func emptyListAlertHiddenStatus(goals: [Goals]) -> Bool {
        switch goalStatus {
        case .completed:
            return  goals.count == 0 ? true : false
        case .inProgress:
            return  goals.count == 0 ? true : false
        }
    }
}
