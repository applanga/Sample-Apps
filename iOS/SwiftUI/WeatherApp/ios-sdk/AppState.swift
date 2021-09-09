//
//  AppState.swift
//  ios-sdk
//

import Combine
import SwiftUI
import Foundation

class AppState: ObservableObject {
    
    @Published var currentWeatherData: CurrentWeatherDataModel?
    @Published var dailyWeatherData: DailyWeatherDataModel?

}
