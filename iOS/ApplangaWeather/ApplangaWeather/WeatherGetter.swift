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
    
    static let weatherForcastApiAddress = "http://api.openweathermap.org/data/2.5/forecast?"

    static let weatherApiKey = "e26e7fc948b9405403b9ee7388e27dfd"
    
    static let locationManager = CLLocationManager()

    static func getWeather( lat : String , long : String , metric : Bool , callback:@escaping(getWeatherResponse?)->())
    {
    print("getting weather")
    let unit = metric ? "metric" : "imperial"
    let requestUrl = weatherApiAddress + "lat=" + lat + "&lon=" + long + "&appid=" + weatherApiKey + "&units=" + unit
        print(requestUrl)
       AF.request(requestUrl).responseDecodable(of: getWeatherResponse.self) { response in
           switch response.result
           {
                case .success:
                   print("Get Current weather success")
                   callback(response.value!)
                    break
                case .failure:
                    print("Got Current weather failed")
                    print(response.error)
                    break
          }
       }
    }
    
    static func getWeatherForcast( lat : String , long : String , metric : Bool , callback:@escaping(getWeatherForcastResponse?)->())
       {
       print("getting weather")
       let unit = metric ? "metric" : "imperial"
       let requestUrl = weatherForcastApiAddress + "lat=" + lat + "&lon=" + long + "&appid=" + weatherApiKey + "&units=" + unit
        print(requestUrl)
          AF.request(requestUrl).responseDecodable(of: getWeatherForcastResponse.self) { response in
              switch response.result
              {
                   case .success:
                      print("Get weather forcast success")
                      callback(response.value!)
                       break
                   case .failure:
                       print("get weather forcast failed")
                       print(response.error)

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
