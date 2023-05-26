//
//  NavMenuView.swift
//  ios-sdk
//

import SwiftUI
struct NavMenuView: View {
    
    let currentView: Views
    var goToHome: () -> Void
    var goToDaily: () -> Void
    var goToAbout: () -> Void
    var goToSettings: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                        .frame(maxHeight: 80)
                }
                
                Image("Logo")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 10)
            
                Text("app_name")
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .padding(.leading, 10)
            
                Text("nav_subtitle")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
            .background(Color(.systemGray6))
            .padding(.top, 10)
            .padding(.bottom, 10)

            NavItemView(destination: Views.home,
                        titleKey: "home_title",
                        icon: "sun.max.fill",
                        isSelected: false,
                        goToDestination: self.goToHome)
                .accessibility(identifier: "navHome")
                
            
            NavItemView(destination: Views.daily,
                        titleKey: "daily_title",
                        icon: "calendar",
                        isSelected: false,
                        goToDestination: self.goToDaily)
                .accessibility(identifier: "navDaily")
            
            NavItemView(destination: Views.about,
                        titleKey: "about_title",
                        icon: "doc.plaintext",
                        isSelected: false,
                        goToDestination: self.goToAbout)
                .accessibility(identifier: "navAbout")
            
            NavItemView(destination: Views.settings,
                        titleKey: "settings_title",
                        icon: "gearshape.fill",
                        isSelected: false,
                        goToDestination: self.goToSettings)
                .accessibility(identifier: "navSettings")
            
            Spacer()
        }
        .frame(width: 280)
        .background(Color(.white))
        .edgesIgnoringSafeArea(.all)
    }
}
