//
//  DailyView.swift
//  ios-sdk
//

import SwiftUI
import Applanga

struct DailyView: View {
    @EnvironmentObject var state: AppState
    
    var title: String {
        let daysCount = AppSettings().getDisplayedDays() ?? 0
        return formattedLocalizedPluralKey("daily_displayed_days",
                                           defaultValue: "Days display",
                                           rule: ALPluralRuleForQuantity(UInt(daysCount)),
                                           formatArguments: daysCount) ?? ""
    }
    
    var body: some View {
        if let daysData = state.dailyWeatherData {
            let daysCount = AppSettings().getDisplayedDays() ?? 0
            VStack {
                titleView
                if daysCount > 0 {
                    daysView(daysData.list, daysCount)
                }
            }
            .background(Color(UIColor.systemGray6))
        }
        else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(x: 3, y: 3, anchor: .center)
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        HStack {
            Spacer()
            
            Text(title)
                .bold()
                .font(.system(size: 26))
                .padding(.top, 20)
                .foregroundColor(Color("textGray"))
            
            Spacer()
        }
        .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    func daysView(_ daysData: [Day], _ count: Int) -> some View {
        ScrollView {
            ForEach(daysData.prefix(8 * count)) { day in
                DayView(
                    dateAndTime: day.dtTxt,
                    icon: day.weather[0].icon,
                    temp: day.main.temp
                )
            }
        }
    }
}
