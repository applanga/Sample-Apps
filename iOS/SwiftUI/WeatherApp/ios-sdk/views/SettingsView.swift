//
//  SettingsView.swift
//  ios-sdk
//

import SwiftUI
import Applanga

struct SettingsView: View {
    @EnvironmentObject var state: AppState
    
    @State var location = ""
    @State var units = "Metric"
    @State var language = AppSettings.Language.english
    @State var displayedDays = 5
    @State var isCityValid = true
    
    var goHome: () -> Void
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Text("settings_location")
                        .font(.system(size: 24))
                        .foregroundColor(Color("textGray"))
                        .bold()
                    
                    TextField(self.location, text: self.$location)
                        .font(.system(size: 22))
                    
                    if (!self.isCityValid) {
                        Text("Given location is an invalid city name.")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                    }
                }
                
                
                Section {
                    Text("settings_measurement_unit")
                        .font(.system(size: 24))
                        .foregroundColor(Color("textGray"))
                        .bold()
                    
                    UnitsRadio(units: self.$units)
                }
                
                
                Section {
                    Text("settings_language")
                        .font(.system(size: 24))
                        .foregroundColor(Color("textGray"))
                        .bold()
                    
                    LangaugeDropdown(selectedValue: self.$language)
                }
                
                
                Section {
                    Text("settings_displayed_days")
                        .font(.system(size: 24))
                        .foregroundColor(Color("textGray"))
                        .bold()
                    
                    DisplayedDaysDropdown(selectedValue: self.$displayedDays)
                }
                
                
                Button(action: saveSettings, label: {
                    HStack {
                        Spacer()
                        Text("settings_save_button")
                            .font(.system(size: 22))
                            .bold()
                        Spacer()
                    }
                })
            }
            
        }
        .onAppear {
            self.location = AppSettings().getLocation()!
            
            self.units = AppSettings().getUnits()!
            
            self.language = AppSettings().getLanguage()!
            
            self.displayedDays = AppSettings().getDisplayedDays()!
        }
    }
    
    func saveSettings() {
        
        // save to settings
        AppSettings().setLocation(location: self.location)
        AppSettings().setUnits(units: self.units)
        AppSettings().setLanguage(language: self.language)
        AppSettings().setDisplayedDays(displayedDays: self.displayedDays)
        
        // make api call
        Repository().getCurrentWeather { currentWeatherDataModel in
            
            // in case of error
            if currentWeatherDataModel == nil {
                // show some error message
                self.isCityValid.toggle()
                return
            }
            
            // set data
            state.currentWeatherData = currentWeatherDataModel
            
            // change language
            let isoCode = languageToIso(language: self.language)
            Applanga.setLanguageAndUpdate(isoCode) { success in
                guard success else {
                    return
                }
                
                // get daily weather
                Repository().getDailyWeather { (DailyWeatherDataModel) in
                    state.dailyWeatherData = DailyWeatherDataModel
                }
                
                // go back to home page
                self.goHome()
            }
            
        }
    }
    
    func languageToIso(language: AppSettings.Language) -> String {
        switch language {
        case .english:
            return "en"
        case .german:
            return "de"
        case .french:
            return "fr"
        }
    }

}
