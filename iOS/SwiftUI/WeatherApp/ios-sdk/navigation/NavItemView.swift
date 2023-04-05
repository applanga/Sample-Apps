//
//  NavItemView.swift
//  ios-sdk
//

import SwiftUI

struct NavItemView: View {
    let destination: Views
    let currentView: Views
    let titleKey: String
    let icon: String
    let goToDestination: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                goToDestination()
            }, label: {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(destination == currentView ? Color("menuPickedText") : .black)
                        .font(.system(size: 30))
                        .padding(.trailing, 5)

                    Text(NSLocalizedString(titleKey, comment: ""))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(destination == currentView ? Color("menuPickedText") : .black)
                }
            })
            .padding(2)
            .padding(.leading, 10)
            
            Spacer()
        }
        .background(destination == currentView ? Color("menuPicked") : .white)
    }
}
