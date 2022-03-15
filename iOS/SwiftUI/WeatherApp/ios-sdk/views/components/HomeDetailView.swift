//
//  HomeDetailView.swift
//  ios-sdk
//

import SwiftUI

struct HomeDetailView: View {
    
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(NSLocalizedString(title, comment: ""))
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxHeight: 25)
                
                Spacer()
                
                Text(content)
                    .font(.system(size: 26))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .frame(maxHeight: 25)
            }

            Divider()
        }
        .padding(5)
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(title: "Beschreibung", content: "broken clouds")
            .background(LinearGradient(
                gradient: Gradient(
                    colors: [Color("Applanga"), Color("ApplangaDark")]

                ), startPoint: .top, endPoint: .bottom
            ))
    }
}