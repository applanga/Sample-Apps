//
//  WeatherUtils.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import Foundation

class WeatherUtils: NSObject {
    static func convertKelvinToCelcius(value : Double)->Double
    {
        return value - 273.15
    }
}
