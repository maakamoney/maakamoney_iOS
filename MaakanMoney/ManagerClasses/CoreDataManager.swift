//
//  CoreDataManager.swift
//  MaakanMoney
//
//  Created by Anand M on 09/05/24.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: NSObject, ObservableObject {
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "MaakaMoney")
    var fetchRequest: NSFetchRequest<Goals>!

    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
    
    func addGoal(goalCaption: String, targetedAmount: Int64, goalCompletionStatus: Bool, goalUsageStatus: Bool, completionHandler: (Result<Int64, Error>) -> Void) {
        let goal = Goals(context: container.viewContext)
        goal.id = UUID()
        goal.goalCaption = goalCaption
        goal.targetedAmount = targetedAmount
        goal.goalCompletionStatus = goalCompletionStatus
        goal.goalUsageStatus = goalUsageStatus
        
        do {
            try container.viewContext.save()
            updateGoals(amount: targetedAmount, completionHandler: completionHandler)
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func updateGoals(amount: Int64, completionHandler: (Result<Int64, Error>) -> Void) {
        do {
            fetchRequest = Goals.fetchRequest()
            fetchRequest.predicate = CoreDataPredicates.fetchProgressGoals.getPredicate()
            let progressGoalList = try container.viewContext.fetch(fetchRequest)
            fetchRequest.predicate = CoreDataPredicates.fetchCompletedGoals.getPredicate()
            let completedGoalList = try container.viewContext.fetch(fetchRequest)
            
            let availableAmount = Utilities.availableAmount - completedGoalList.reduce(0) { $0 + $1.targetedAmount }
            let equalAmount = progressGoalList.count == 0 ? availableAmount : availableAmount/Int64(progressGoalList.count)
            
            _ = progressGoalList.map { goal in
                if  equalAmount >= goal.targetedAmount {
                    goal.goalCompletionStatus = true
                }
                return goal
            }
            try container.viewContext.save()
            completionHandler(.success(amount))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func achieveGoal(goalId: UUID?, availableAmount: Int64, completionHandler: (Result<Int64, Error>) -> Void) {
        fetchRequest = Goals.fetchRequest()
        fetchRequest.predicate = CoreDataPredicates.fetchCompletedGoals.getPredicate()
        do {
            let completedGoalList = try container.viewContext.fetch(fetchRequest)
            completedGoalList.filter { goal in
                goal.id == goalId
            }.first?.goalUsageStatus = true
            try container.viewContext.save()
            Utilities.availableAmount = availableAmount
            completionHandler(.success(availableAmount))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func saveMoney(availableAmount: Int64, transactionAmount: Int64, transactionType: Int16, transactionOrder: Int16, completionHandler: (Result<Int64, Error>) -> Void) {
        let transactionHistory = TransactionHistory(context: container.viewContext)
        transactionHistory.id = UUID()
        transactionHistory.availableAmount = availableAmount
        transactionHistory.transactionAmount = transactionAmount
        transactionHistory.transactionType = transactionType
        transactionHistory.transactionOrder = transactionOrder
        
        do {
            try container.viewContext.save()
            Utilities.availableAmount = availableAmount
            updateGoals(amount: transactionAmount, completionHandler: completionHandler)
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func deleteGoal(goal: NSManagedObject) {
        container.viewContext.delete((goal))
        do {
            try container.viewContext.save()
        } catch {
            // TODO: Handle this error in UI
        }
    }
}
