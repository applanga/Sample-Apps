//
//  DayView.swift
//  ios-sdk
//

import SwiftUI

struct DayView: View {
    
    let dateAndTime: String
    let icon: String
    let temp: Double
        
    var body: some View {
        HStack {
            
            VStack {
                
                VStack {
                    
                    HStack {
                        Spacer()
                    }
                    
                    WeatherImageView(iconCode: icon)
                        .font(.system(size: 105))
                        .shadow(radius: 5)
                    
                }
                .padding(.top, 30)
                .padding(.bottom, 25)
                .background(LinearGradient(
                    gradient: Gradient(
                        colors: [Color("ApplangaLight"), Color("Applanga")]

                    ), startPoint: .leading, endPoint: .bottom
                ))
                

                VStack {
                    
                    HStack {
                        Spacer()
                    }
                    
                    Text(getFullDateFromString(str: dateAndTime))
                        .font(.system(size: 26))
                        .bold()
                        .foregroundColor(Color(.darkGray))
                    
                    Spacer()
                    
                    Text("\(Int(round(temp)))°")
                        .font(.system(size: 36))
                        .bold()
                        .foregroundColor(Color("textGray"))
                    
                    Spacer()
                    
                    Text(getTimeFromString(str: dateAndTime))
                        .font(.system(size: 26))
                        .bold()
                        .foregroundColor(Color(.darkGray))
                        
                    
                }
                .padding(.bottom, 20)

            }
            
        }
        .background(Color.white)
        .frame(height: 320)
        .cornerRadius(15)
        .padding(20)
        .shadow(radius: 7)
        
    }

}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(
            dateAndTime: "2021-03-18 18:00:00",
            icon: "03d",
            temp: 9.24
        )
    }
}
