//
//  WeatherRequestModel.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import Foundation
class getWeatherResponse: Codable
{
    var weather : [weatherObject]
    var main : tempData
}

class getWeatherForcastResponse: Codable
{
    var list : [weatherEntry]
}

class weatherObject: Codable
{
    var id : Int
    var main : String
    var description: String
    var icon : String
}


class tempData: Codable
{
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var humidity : Int
}

class weatherEntry: Codable
{
    var dt : Double
    var main : tempData
    var weather : [weatherObject]
}
