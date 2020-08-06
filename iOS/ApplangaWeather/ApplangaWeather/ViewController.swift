//
//  ViewController.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

   
    @IBOutlet weak var mainTemperatureLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
        WeatherGetter.getWeather(metric: true, callback: setupWeatherLabels)
        
    }
    
    func initViewElements()
    {
        mainTemperatureLabel.text = "--°c"
        weatherDescriptionLabel.text = ""
    }
    
    func setupWeatherLabels(weather : getWeatherResponse?)
    {
        mainTemperatureLabel.text = String(weather!.main.temp) + "°c"
        
        let weatherKey = String(weather!.weather[0].id)
        
        weatherDescriptionLabel.text = NSLocalizedString(weatherKey,value: "", comment: "")
    }

    
   
    
}

