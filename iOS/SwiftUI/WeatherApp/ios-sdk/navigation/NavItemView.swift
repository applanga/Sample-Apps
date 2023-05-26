//
//  NavItemView.swift
//  ios-sdk
//

import SwiftUI

struct NavItemView: View {
    let destination: Views
    let titleKey: String
    let icon: String
    let isSelected: Bool
    let goToDestination: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                goToDestination()
            }, label: {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(isSelected ? Color("menuPickedText") : .black)
                        .font(.system(size: 30))
                        .padding(.trailing, 5)

                    Text(LocalizedStringKey(titleKey))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(isSelected ? Color("menuPickedText") : .black)
                }
            })
            .padding(2)
            .padding(.leading, 10)
            
            Spacer()
        }
        .background(isSelected ? Color("menuPicked") : .white)
    }
}
