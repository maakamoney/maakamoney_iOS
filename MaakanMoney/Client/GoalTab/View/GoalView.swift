//
//  GoalView.swift
//  MaakanMoney
//
//  Created by Anand M on 29/03/24.
//

import SwiftUI
import Combine

struct GoalView: View {
    
    @StateObject private var goalViewModel: GoalViewModel = GoalViewModel()
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "targetedAmount", ascending: false)]) private var goals: FetchedResults<Goals>
    @State private var showingSetGoalView = false
    @State private var showAchieveGoalStatusAlert = false
    @State private var alertMessage = MMConstants.emptyString
    @AppStorage(MMConstants.availableAmount) var totalSavings = 0.0
    
    func amountRowView(amount: String, caption: String) -> some View {
        HStack {
            Text(caption).font(.footnote)
            Spacer()
            HStack {
                Label(String(amount), systemImage: MMConstants.ImagePaths.rupees).font(.footnote)
                    .labelStyle(.titleAndIcon)
                Spacer()
            }.frame(width: 80)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(MMConstants.TitleText.totalSavings).font(.headline).fontWeight(.semibold)
                Spacer()
                Label(String(totalSavings), systemImage: MMConstants.ImagePaths.rupees).font(.headline).fontWeight(.semibold)
                    .labelStyle(.titleAndIcon)
            }.padding().background(Color.black.opacity(0.10))
            Picker(MMConstants.TitleText.goals, selection: $goalViewModel.goalStatus) {
                Text(MMConstants.TitleText.inProgress).tag(GoalStatus.inProgress)
                Text(MMConstants.TitleText.completed).tag(GoalStatus.completed)
            }
            .pickerStyle(.segmented)
            .padding()
            VStack(spacing: 0) {
                ZStack {
                    List(goalViewModel.goalStatus == .completed ? goals.filter{$0.goalCompletionStatus} : goals.filter{!$0.goalCompletionStatus} , id: \.self) { goalDetail in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(goalDetail.goalCaption ?? MMConstants.emptyString).font(.subheadline).fontWeight(.semibold).padding(.leading, 10).padding(.top, goalViewModel.goalStatus == .inProgress ? 0 : 10)
                                Spacer()
                                if goalViewModel.goalStatus == .inProgress {
                                    MMUIButton(buttonType: .icon(withBackground: false), iconDetails: (MMConstants.ImagePaths.trash, isSystemImage: true, size: (16, 18)), foregroundColor: AppTheme.errorColor) {
                                        coreDataManager.deleteGoal(goal: goalDetail)
                                    }
                                }
                            }
                            amountRowView(amount: String(goalDetail.targetedAmount), caption: MMConstants.TitleText.amountTargeted).padding(.leading, 10)
                            if goalViewModel.goalStatus == .inProgress {
                                amountRowView(amount: "****", caption: MMConstants.TitleText.amountSaved).padding(.bottom, 10).padding(.leading, 10)
                            } else {
                                ZStack {
                                    Rectangle().foregroundColor(AppTheme.primaryColor.opacity(0.1))
                                    HStack {
                                        Text(goalDetail.goalUsageStatus ? MMConstants.TitleText.achievedGoal : MMConstants.TitleText.unlockedGoal).font(.caption).foregroundColor(AppTheme.primaryColor).padding(10)
                                        if !goalDetail.goalUsageStatus {
                                            Spacer()
                                            // TODO: Change this native button to MMButton
                                            Button {
                                                coreDataManager.achieveGoal(goalId: goalDetail.id, availableAmount: Utilities.availableAmount - goalDetail.targetedAmount) {
                                                    switch $0 {
                                                    case .failure(_):
                                                        alertMessage = MMConstants.achieveGoalFailed
                                                        showAchieveGoalStatusAlert.toggle()
                                                    case .success(let withdrawnAmount):
                                                        print(withdrawnAmount)
                                                    }
                                                }
                                            } label: {
                                                Text(MMConstants.TitleText.achieveGoal).font(.system(size: 12, weight: .semibold)).padding(.trailing, 10)
                                            }
                                        }
                                    }
                                }.fixedSize(horizontal: false, vertical: true).padding(.top)
                            }
                        }.buttonStyle(.plain) .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                         .listRowSeparator(goalViewModel.goalStatus == .inProgress ? .visible : .hidden)
                    }.listStyle(.plain)
                    MMUIAlertMessage(title: goalViewModel.getEmptyListAlertDetails().title, description: goalViewModel.getEmptyListAlertDetails().description, imagePath: MMConstants.ImagePaths.emptyGoals).opacity(goalViewModel.emptyListAlertHiddenStatus(goals: goalViewModel.goalStatus == .completed ? goals.filter{$0.goalCompletionStatus} : goals.filter{!$0.goalCompletionStatus}) ? 1 : 0)
                }
                MMUIButton(buttonType: .defaultStyle(fixedSize: true, withIcon: false, buttonType: .capsule), title: MMConstants.TitleText.setGoal, foregroundColor: AppTheme.secondaryOverlayColor, backgroundColor: AppTheme.secondaryColor) {
                    showingSetGoalView.toggle()
                }.padding(10)
            }.background(.white)
        }.sheet(isPresented: $showingSetGoalView) {
            SetGoalsView(showingSetGoalView: $showingSetGoalView)
        }
        .alert(isPresented: $showAchieveGoalStatusAlert) {
            Alert(title: Text(MMConstants.achieveGoal), message: Text(alertMessage), dismissButton: .default(Text(MMConstants.ok)))
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
