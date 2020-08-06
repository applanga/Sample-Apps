//
//  WeatherGetter.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import Foundation
import Alamofire

class WeatherGetter: NSObject {
    
    //https://openweathermap.org/current#parameter
    
    static let weatherApiAddress = "http://api.openweathermap.org/data/2.5/weather?"

    static let weatherApiKey = "e26e7fc948b9405403b9ee7388e27dfd"
    
    static func getWeather(metric : Bool,callback:@escaping(getWeatherResponse?)->())
   {
    print("getting weather")

    let unit = metric ? "metric" : "imperial"
    let requestUrl = weatherApiAddress + "q=dresden" + "&appid=" + weatherApiKey + "&units=" + unit
       AF.request(requestUrl).responseDecodable(of: getWeatherResponse.self) { response in
           switch response.result
           {
                case .success:
                   print("Got weather success")
                   callback(response.value!)
                    break
                case .failure:
                    print("Got weather failed")
                    print(response.error)
                    print(response.description)
                    break
          }
       }
     
   }
       
       
}
