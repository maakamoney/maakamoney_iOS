//
//  SetGoalsView.swift
//  MaakanMoney
//
//  Created by Anand M on 16/03/24.
//

import SwiftUI
import Combine

struct SetGoalsView: View {

    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject private var setGoalViewModel: SetGoalViewModel = SetGoalViewModel()
    @FocusState private var currentFocusedField: FocusedField?
    @State private var showGoalStatusAlert = false
    @State private var alertMessage = MMConstants.emptyString
    @Binding private var showingSetGoalView: Bool
    
    init(showingSetGoalView: Binding<Bool> = .constant(false), applyAdaptiveKeyboard: Bool = false) {
        _showingSetGoalView = showingSetGoalView
        self.applyAdaptiveKeyboard = applyAdaptiveKeyboard
        self.currentFocusedField = .goalAmount
    }
    
    var applyAdaptiveKeyboard: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !applyAdaptiveKeyboard {
                Text(MMConstants.TitleText.setGoalHeading).font(.title3).bold().padding(.horizontal)
                Text(MMConstants.TitleText.setGoalSubHeading).font(.caption).padding(.horizontal).padding(.bottom, 50)
            }
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Text(MMConstants.TitleText.targetedAmount).foregroundColor(AppTheme.primaryColor    ).font(.subheadline)
                    HStack(spacing: 0) {
                        Image(systemName: MMConstants.ImagePaths.rupees).resizable().frame(width: 12, height: 20)
                        MMUITextField(value: $setGoalViewModel.targetedAmount, placeHolder: MMConstants.TitleText.zero, fontDetails: (size: 42, weight: .medium), keyboardType: .numberPad, textFieldType: .backgroundColor(.clear), textLimit: 10).focused($currentFocusedField, equals: .goalAmount)
                    }.fixedSize()
                    MMUITextField(value: $setGoalViewModel.goalCaption, placeHolder: MMConstants.TitleText.goalCaption, fontDetails: (size: 16, weight: .medium), keyboardType: .alphabet, textFieldType: .backgroundColor(.gray), textLimit: 100).fixedSize().focused($currentFocusedField, equals: .goalCaption)
                    Spacer()
                    HStack {
                        MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.cancel) {
                            showingSetGoalView.toggle()
                        }
                        MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.save) {
                            coreDataManager.addGoal(goalCaption: setGoalViewModel.goalCaption, targetedAmount: Int64(setGoalViewModel.targetedAmount) ?? 0, goalCompletionStatus: false, goalUsageStatus: false) {
                                switch $0 {
                                case .failure(_):
                                    alertMessage = MMConstants.addingMoneyFailed
                                case .success(let savingAmount):
                                    MMConstants.addingMoneySucceeded = String(savingAmount)
                                    alertMessage = MMConstants.addingMoneySucceeded
                                }
                                showGoalStatusAlert.toggle()
                            }
                        }.opacity(setGoalViewModel.getMandatoryFieldStatus() ? 0.5 : 1)
                         .disabled(setGoalViewModel.getMandatoryFieldStatus())
                    }.padding(.bottom, !applyAdaptiveKeyboard ? -20 : 0)
                }
                Spacer()
            }
        }.padding(.vertical, 30)
         .keyboardAdaptive(applyAdaptiveKeyboard: applyAdaptiveKeyboard)
         .onAppear() {
            currentFocusedField = .goalAmount
            setGoalViewModel.coreDataManager = coreDataManager
         }
         .alert(isPresented: $showGoalStatusAlert) {
             Alert(title: Text(MMConstants.goalCreated), message: Text(MMConstants.createMoreGoal), primaryButton: .default(Text(MMConstants.yes), action: {
                 setGoalViewModel.targetedAmount = MMConstants.emptyString
                 setGoalViewModel.goalCaption = MMConstants.emptyString
                 currentFocusedField = .goalAmount
             }), secondaryButton: .cancel(Text(MMConstants.no), action: {
                 showingSetGoalView.toggle()
             }))
         }
    }
}


