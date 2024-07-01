//
//  MMUIButton.swift
//  MaakanMoney
//
//  Created by Anand M on 14/03/24.
//

import SwiftUI

struct MMUIButton: View {
    
    //MARK: Observed Properties
    @Binding var isLoading: Bool
    
    //MARK: Stored Properties
    var buttonType: MMUIButtonTypes
    var iconDetails: (iconDetails: String, isSystemImage: Bool, size: (CGFloat, CGFloat))
    var title: String
    var completionHandler: () -> ()
    var foregroundColor: Color = AppTheme.primaryOverlayColor
    var backgroundColor: Color = AppTheme.primaryColor
    
    init (buttonType: MMUIButtonTypes, title: String = MMConstants.emptyString, iconDetails: (iconDetails: String, isSystemImage: Bool, size: (CGFloat, CGFloat)) = (MMConstants.emptyString, true, (20,20)), foregroundColor: Color = AppTheme.secondaryOverlayColor, backgroundColor: Color = AppTheme.secondaryColor, isLoading: Binding<Bool> = .constant(false), completionHandler: @escaping () -> ()) {
        self.buttonType = buttonType
        self.title = title
        self.iconDetails = iconDetails
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.completionHandler = completionHandler
        _isLoading = isLoading
    }
    
    var isFixedSize: Bool {
        switch buttonType {
        case .defaultStyle(fixedSize: let fixedSize, withIcon: _, buttonType: _):
            return fixedSize
        default:
            return true
        }
    }
    
    var isIconStyle: Bool {
        switch buttonType {
        case .icon(withBackground: _):
            return true
        default:
            return false
        }
    }
    
    var isDefaultStyleWithIcon: Bool {
        switch buttonType {
        case .defaultStyle(fixedSize: _, withIcon: let withIcon, buttonType: _):
            return withIcon
        default:
            return true
        }
    }
    
    var background: some View {
        switch buttonType {
        case .icon(withBackground: let withBackground):
            return RoundedRectangle(cornerRadius: 8).foregroundColor(withBackground ? backgroundColor : .clear)
        case .defaultStyle(fixedSize: _, withIcon: _, buttonType: let buttonType):
            return RoundedRectangle(cornerRadius: buttonType == .capsule ? 20 : 8).foregroundColor(buttonType == .label ? .clear : backgroundColor)
        default:
            return RoundedRectangle(cornerRadius: 8).foregroundColor(backgroundColor)
        }
    }
    
    var isCapsuleButton: Bool {
        switch buttonType {
        case .defaultStyle(fixedSize: _, withIcon: _, buttonType: let buttonType):
            return buttonType == .capsule
        default:
            return false
        }
    }
    
    var body: some View {
        VStack {
            Button {
                completionHandler()
            } label: {
                ZStack {
                    if !(buttonType == .label) {
                        background
                    }
                    if isLoading {
                        ProgressView().tint(AppTheme.primaryOverlayColor)
                    }
                    if !(buttonType == .label) {
                        HStack(spacing: 0) {
                            if isDefaultStyleWithIcon {
                                Image(isSystemImage: iconDetails.isSystemImage, iconPath: iconDetails.iconDetails).resizable().frame(width: iconDetails.size.0, height: iconDetails.size.1).foregroundColor(foregroundColor).padding(.leading, isIconStyle ? 0 : 20)
                                    .opacity(isLoading ? 0 : 1)
                            }
                            if !isIconStyle {
                                Text(title).font(.system(size: 14, weight: .medium))
                                    .foregroundColor(foregroundColor)
                                    .padding(.trailing,isDefaultStyleWithIcon ? 20 : 40)
                                    .padding(.leading, isDefaultStyleWithIcon ? 10 : 40)
                                    .opacity(isLoading ? 0 : 1)
                            }
                        }
                    } else {
                        Text(title).font(.system(size: 14, weight: .medium))
                            .foregroundColor(foregroundColor)
                    }
                }.frame(width: isIconStyle ? 50 : nil, height: isCapsuleButton ? 40 : 50).fixedSize(horizontal: isFixedSize, vertical: false)
            }
        }
    }
}

struct MMUIButton_Previews: PreviewProvider {
    static var previews: some View {
        MMUIButton(buttonType: .icon(withBackground: true), iconDetails: (iconDetails: MMConstants.ImagePaths.checkedBox, isSystemImage: true, size: (20, 20)), foregroundColor: .red, isLoading: .constant(false)) {
            
        }
    }
}
