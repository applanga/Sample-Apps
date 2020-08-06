//
//  WeatherGetter.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherGetter: NSObject, CLLocationManagerDelegate {
    
    //https://openweathermap.org/current#parameter
    
    static let weatherApiAddress = "http://api.openweathermap.org/data/2.5/weather?"

    static let weatherApiKey = "e26e7fc948b9405403b9ee7388e27dfd"
    
    static let locationManager = CLLocationManager()

    static func getWeather( lat : String , long : String , metric : Bool , callback:@escaping(getWeatherResponse?)->())
    {
    print("getting weather")

    let unit = metric ? "metric" : "imperial"
    let requestUrl = weatherApiAddress + "lat=" + lat + "&lon=" + long + "&appid=" + weatherApiKey + "&units=" + unit
       AF.request(requestUrl).responseDecodable(of: getWeatherResponse.self) { response in
           switch response.result
           {
                case .success:
                   print("Got weather success")
                   callback(response.value!)
                    break
                case .failure:
                    print("Got weather failed")
                    break
          }
       }
    }
    
    static func getWeatherIcon(iconName: String,callback:@escaping(UIImage?)->())
    {
        AF.request("http://openweathermap.org/img/wn/" + iconName + "@2x.png").response { response in
            callback(UIImage(data: response.data!, scale:1))
        }
    }
       
}
