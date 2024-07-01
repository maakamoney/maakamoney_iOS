//
//  MMUIAlertMessage.swift
//  MaakaMoney
//
//  Created by Anand M on 13/06/24.
//

import SwiftUI

struct MMUIAlertMessage: View {
    
    //MARK: Stored Properties
    var title: String
    var description: String
    var imagePath: String
    
    //MARK: Computed Properties
    var body: some View {
        GeometryReader { size in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image(imagePath).resizable().frame(width:  size.size.width/2, height:  size.size.width/2).padding(.vertical, 40)
                    Text(title).font(.title3).fontWeight(.semibold)
                    Text(description).foregroundStyle(.gray).multilineTextAlignment(.center).font(.subheadline)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MMUIAlertMessage(title: MMConstants.TitleText.emptyInprogressGoalsTitle, description: MMConstants.TitleText.emptyInprogressGoalsDescription, imagePath: MMConstants.ImagePaths.emptyGoals)
}
