//
//  SaveMoneyView.swift
//  MaakanMoney
//
//  Created by Anand M on 17/04/24.
//

import SwiftUI
import Combine

struct SaveMoneyView: View {
    
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject private var saveMoneyViewModel: SaveMoneyViewModel = SaveMoneyViewModel()
    @State private var showSavingMoneyStatusAlert = false
    @State private var alertMessage = MMConstants.emptyString
    @Binding var showingSaveMoneyView: Bool
    @FocusState var currentFocusedField: FocusedField?
    
    var applyAdaptiveKeyboard: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !applyAdaptiveKeyboard {
                Text(MMConstants.TitleText.saveMoneyHeading).font(.title3).bold().padding(.horizontal)
                Text(MMConstants.TitleText.saveMoneySubHeading).font(.caption).padding(.horizontal).padding(.bottom, 50)
            }
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Text(MMConstants.TitleText.savingAmount).foregroundColor(AppTheme.primaryColor    ).font(.subheadline)
                    HStack(spacing: 0) {
                        Image(systemName: MMConstants.ImagePaths.rupees).resizable().frame(width: 12, height: 20)
                        MMUITextField(value: $saveMoneyViewModel.savingAmount, placeHolder: MMConstants.TitleText.zero, fontDetails: (size: 42, weight: .medium), keyboardType: .numberPad, textFieldType: .backgroundColor(.clear), textLimit: 10).focused($currentFocusedField, equals: .goalAmount)
                    }.fixedSize()
                    Spacer()
                    HStack {
                        MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.cancel) {
                            showingSaveMoneyView.toggle()
                        }
                        MMUIButton(buttonType: .defaultStyle(fixedSize: false, withIcon: false, buttonType: .roundedCorner), title: MMConstants.TitleText.save) {
                            coreDataManager.saveMoney(availableAmount: Utilities.availableAmount + (Int64(saveMoneyViewModel.savingAmount) ?? 0), transactionAmount: (Int64(saveMoneyViewModel.savingAmount) ?? 0), transactionType: Int16(TransactionType.deposite.rawValue), transactionOrder: Utilities.transactionOrder + 1) {
                                switch $0 {
                                case .failure(_):
                                    alertMessage = MMConstants.addingMoneyFailed
                                case .success(let savingAmount):
                                    MMConstants.addingMoneySucceeded = String(savingAmount)
                                    alertMessage = MMConstants.addingMoneySucceeded
                                }
                                showSavingMoneyStatusAlert.toggle()
                            }
                        }.opacity(saveMoneyViewModel.getMandatoryFieldStatus() ? 0.5 : 1)
                         .disabled(saveMoneyViewModel.getMandatoryFieldStatus())
                    }.padding(.bottom, !applyAdaptiveKeyboard ? -20 : 0)
                }
                Spacer()
            }
        }.padding(.vertical, 30)
         .keyboardAdaptive(applyAdaptiveKeyboard: applyAdaptiveKeyboard)
         .onAppear() {
             currentFocusedField = .goalAmount
         }
         .alert(isPresented: $showSavingMoneyStatusAlert) {
             Alert(title: Text(MMConstants.saveMoney), message: Text(alertMessage), dismissButton: .default(Text(MMConstants.ok)) {
                 showingSaveMoneyView.toggle()
             })
         }
    }
}

