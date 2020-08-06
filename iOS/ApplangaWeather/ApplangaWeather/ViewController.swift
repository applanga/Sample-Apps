//
//  ViewController.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 06.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController ,CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var mainTemperatureLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
        updateWeather()
    }
    
    func initViewElements()
    {
        mainTemperatureLabel.text = ""
        weatherDescriptionLabel.text = ""
        locationLabel.text = ""
    }
    
    func setupWeatherLabels(weather : getWeatherResponse?)
    {
        mainTemperatureLabel.text = String(format: "%.0f",weather!.main.temp) + "°c"
        
        let weatherKey = String(weather!.weather[0].id)
        
        weatherDescriptionLabel.text = NSLocalizedString(weatherKey,value: "", comment: "")
        
        WeatherGetter.getWeatherIcon(iconName: weather!.weather[0].icon)
        {
            image in
            self.weatherIcon.image = image
        }

    }
    
    func updateWeather()
       {
        print("Request Location")
           // Ask for Authorisation from the User.
           self.locationManager.requestWhenInUseAuthorization()
           if CLLocationManager.locationServicesEnabled() {
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
               locationManager.startUpdatingLocation()
            }
       }
       
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let locValue:CLLocationCoordinate2D = manager.location!.coordinate
         print("locations = \(locValue.latitude) \(locValue.longitude)")
        WeatherGetter.getWeather(lat: String(locValue.latitude),long: String(locValue.longitude), metric: true, callback: setupWeatherLabels)
       
               let geoCoder = CLGeocoder()
               geoCoder.reverseGeocodeLocation(manager.location!, completionHandler:
                   {
                       placemarks, error -> Void in
                       // Place details
                       guard let placeMark = placemarks?.first else { return }
                       if let city = placeMark.subAdministrativeArea {
                            print(city)
                            self.locationLabel.text = city
                       }
               })
        locationManager.stopUpdatingLocation()

     }
    
}

