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
                Text(LocalizedStringKey(title))
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxHeight: 25)
                
                Spacer()
                
                Text(content)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textGray"))
                    .frame(maxHeight: 25)
            }

            Divider()
        }
        .padding(5)
    }
}

