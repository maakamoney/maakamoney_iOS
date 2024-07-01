//
//  MMUITextField.swift
//  MaakanMoney
//
//  Created by Anand M on 08/03/24.
//

import SwiftUI
import Combine

struct MMUITextField: View {
    
    //MARK: Observed Properties
    @Binding var value: String
    
    //MARK: Stored Properties
    var placeHolder: String
    var fontDetails: (size: CGFloat, weight: Font.Weight) = (size: 24, weight: .semibold)
    var keyboardType: UIKeyboardType = .alphabet
    var textFieldType: MMUITextFieldTypes = .withSeparator
    var textLimit: Int! = nil
    var backspaceEvent: (() -> ())?
    
    //MARK: Computed Properties
    @ViewBuilder
    var getTextFieldBackground: some View {
        switch textFieldType {
        case .withSeparator, .defaultStyle, .singleCharacter:
            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
        case .backgroundColor(let backgroundColor):
            RoundedRectangle(cornerRadius:8)
                .foregroundColor(backgroundColor).opacity(0.1)
        }
    }
    
    @ViewBuilder
    var getTextField: some View {
        switch textFieldType {
        case .withSeparator, .defaultStyle, .backgroundColor:
            TextField(textFieldType == .defaultStyle ? MMConstants.emptyString : placeHolder, text: $value)
                .font(.system(size: fontDetails.size, weight: fontDetails.weight))
                .keyboardType(keyboardType)
                .padding(.horizontal, 10)
                .autocorrectionDisabled(true)
        case .singleCharacter:
            SingleDigitTF(singleDigit: $value, placeholder: placeHolder) { a in
                backspaceEvent?()
            }.fixedSize()
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                getTextFieldBackground
                if textFieldType == .defaultStyle {
                    topPlaceHolder(placeHolder: placeHolder)
                }
                HStack {
                    if textFieldType == .withSeparator {
                        Text(MMConstants.TitleText.countryCode).font(.system(size: fontDetails.size, weight: fontDetails.weight))
                            .padding(.horizontal, 10)
                        Divider()
                            .frame(height: 30)
                            .frame(minWidth: 1)
                            .overlay(Color.black)
                    }
                    getTextField
                        .onReceive(Just(value)) { a in
                            if textLimit != nil {
                                limitText(textLimit)
                            }
                        }
                }
            }
            .frame(width: textFieldType == .singleCharacter ? 50 : nil, height: 50)
        }
    }
    
    /// Returns placeholder which will be placed on top left corner of the textfield
    func topPlaceHolder(placeHolder: String) ->  some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle().foregroundColor(AppTheme.primaryOverlayColor)
                    Text(placeHolder).font(.system(size: 14, weight: fontDetails.weight)).padding(.horizontal, 12)
                }.fixedSize()
                Spacer()
            }
            Spacer()
        }.offset(x: 10, y: -10)
    }
    
    /// Limit the number characters allowed by a textfield
    func limitText(_ upper: Int) {
        if value.count > upper {
            value = String(value.prefix(upper))
        }
    }
}

struct MMUITextField_Previews: PreviewProvider {
    static var previews: some View {
        MMUITextField(value: .constant(MMConstants.emptyString), placeHolder: "0", backspaceEvent: nil)
    }
}

struct SingleDigitTF: UIViewRepresentable {
    
    @Binding var singleDigit: String
    let placeholder: String
    let onBackspace: (Bool) -> Void
    
    func makeCoordinator() -> SingleDigitTFCoordinator {
        SingleDigitTFCoordinator(singleDigit: $singleDigit)
    }
    
    func makeUIView(context: Context) -> SingleDigitTF {
        let singleDigitTF = SingleDigitTF()
        singleDigitTF.placeholder = placeholder
        singleDigitTF.keyboardType = .numberPad
        singleDigitTF.autocorrectionType = .no
        singleDigitTF.delegate = context.coordinator
        singleDigitTF.font = .systemFont(ofSize: 24)
        return singleDigitTF
    }
    
    func updateUIView(_ singleDigitTF: SingleDigitTF, context: Context) {
        singleDigitTF.text = singleDigit
        singleDigitTF.onBackspace = onBackspace
    }
    
    class SingleDigitTF: UITextField {
        
        var onBackspace: ((Bool) -> Void)?
        
        override init(frame: CGRect) {
            onBackspace = nil
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func deleteBackward() {
            onBackspace?(text?.isEmpty == true)
            super.deleteBackward()
        }
    }
}

class SingleDigitTFCoordinator: NSObject, UITextFieldDelegate {
    
    var singleDigit: Binding<String>
    
    init(singleDigit: Binding<String>) {
        self.singleDigit = singleDigit
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        singleDigit.wrappedValue = string
        let currentText = textField.text ?? MMConstants.emptyString
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
}

