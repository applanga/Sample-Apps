//
//  DailyView.swift
//  ios-sdk
//

import SwiftUI
import Applanga

struct DailyView: View {
    
    @EnvironmentObject var state: AppState
    var displayText: String
    var displayedDays: Int
    
    init() {
        self.displayedDays = AppSettings().getDisplayedDays()!
        
        self.displayText = NSString.localizedStringWithFormat(NSString(string:(Applanga.localizedString(forKey: "displayed_days_title", withDefaultValue: "Days display", andArguments: nil, andPluralRule: ALPluralRuleForQuantity(UInt(displayedDays))))), displayedDays) as String
    }
    
    var body: some View {
        
        if (state.dailyWeatherData == nil) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(x: 3, y: 3, anchor: .center)
        } else {
            VStack {
                
                HStack {
                    Spacer()
                    
                    Text(displayText)
                        .bold()
                        .font(.system(size: 26))
                        .padding(.top, 20)
                        .foregroundColor(Color("textGray"))
                    
                    Spacer()
                }
                .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                ScrollView {
 
                        ForEach(state.dailyWeatherData!.list.prefix(self.displayedDays * 8)) { day in
                            DayView(
                                dateAndTime: day.dtTxt,
                                icon: day.weather[0].icon,
                                temp: day.main.temp
                            )
                        }

                }
            }
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
