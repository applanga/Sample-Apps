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
            
                Text(NSLocalizedString("app_name", comment: ""))
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .padding(.leading, 10)
            
                Text(NSLocalizedString("nav_subtitle", comment: ""))
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
            .background(Color(.systemGray6))
            .padding(.top, 10)
            .padding(.bottom, 10)

            NavItemView(destination: Views.home, currentView: self.currentView, titleKey: "home_page", icon: "sun.max.fill", goToDestination: self.goToHome)
                .accessibility(identifier: "navHome")
                
            
            NavItemView(destination: Views.daily, currentView: self.currentView, titleKey: "daily_page", icon: "calendar", goToDestination: self.goToDaily)
                .accessibility(identifier: "navDaily")
            
            NavItemView(destination: Views.about, currentView: self.currentView, titleKey: "about_page", icon: "doc.plaintext", goToDestination: self.goToAbout)
                .accessibility(identifier: "navAbout")
            
            NavItemView(destination: Views.settings, currentView: self.currentView, titleKey: "settings_page", icon: "gearshape.fill", goToDestination: self.goToSettings)
                .accessibility(identifier: "navSettings")
            
            Spacer()
                
        }
        .frame(width: 280)
        .background(Color(.white))
        .edgesIgnoringSafeArea(.all)
    }
}

//struct NavMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            NavMenuView(currentView: Views.home),
//        }
//        .background(LinearGradient(
//            gradient: Gradient(
//                colors: [Color("Applanga"), Color("ApplangaDark")]
//
//            ), startPoint: .top, endPoint: .bottom
//        ))
//    }
//}




