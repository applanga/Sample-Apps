//
//  AppState.swift
//  WeatherSample
//

import Foundation

class AppState {
    var currentWeather: CurrentWeatherDataModel?
    var dailyWeather: DailyWeatherDataModel?
    
    private init() {}
    
    static let shared = AppState()
    
    func setCurrentWeather(currentWeather: CurrentWeatherDataModel?) {
        self.currentWeather = currentWeather
        NotificationCenter.default.post(name: .weatherUpdated, object: nil)
    }
    
    func setDailyWeather(dailyWeather: DailyWeatherDataModel?) {
        self.dailyWeather = dailyWeather
        NotificationCenter.default.post(name: .weatherUpdated, object: nil)
    }
}

extension Notification.Name {
    static let userLanguageChanged = Notification.Name("userLanguageChanged")
    static let weatherUpdated = Notification.Name("weatherUpdated")
}
