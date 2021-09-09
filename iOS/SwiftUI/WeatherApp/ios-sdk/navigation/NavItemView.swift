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

//struct NavItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavItemView(
//            destination: Views.home,
//            currentView: Views.settings,
//            titleKey: "home_page",
//            icon: "sun.max.fill"
////            goToView: () -> Void
//        )
//    }
//}
