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
    
    @IBOutlet weak var ForcastList: UITableView!
    
    var forcastEntries : [weatherEntry]? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForcastList.delegate = self
        ForcastList.dataSource = self
        initViewElements()
        updateWeather()
    }
    
    func initViewElements()
    {
        mainTemperatureLabel.text = ""
        weatherDescriptionLabel.text = ""
        locationLabel.text = ""
    }
    
    func setupCurrentWeatherLabels(weather : getWeatherResponse?)
    {
        mainTemperatureLabel.text = String(format: "%.0f°C",weather!.main.temp)
        let weatherKey = String(weather!.weather[0].id)
        weatherDescriptionLabel.text = NSLocalizedString(weatherKey,value: "", comment: "")
        WeatherGetter.getWeatherIcon(iconName: weather!.weather[0].icon)
        {
            image in
            self.weatherIcon.image = image
        }

    }
    
    func setupForcastList(weather : getWeatherForcastResponse?)
    {
        forcastEntries = weather?.list
        ForcastList.reloadData()
    }
    
    func updateWeather()
    {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
       
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
     {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        WeatherGetter.getWeather(lat: String(locValue.latitude),long: String(locValue.longitude), metric: true, callback: setupCurrentWeatherLabels)
        WeatherGetter.getWeatherForcast(lat: String(locValue.latitude), long: String(locValue.longitude), metric: true, callback: setupForcastList)
        setupLocationLabel(location: manager.location!)
        locationManager.stopUpdatingLocation()
     }
    
    func setupLocationLabel(location : CLLocation?)
    {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!, completionHandler:
            {
                placemarks, error -> Void in
                guard let placeMark = placemarks?.first else { return }
                if let city = placeMark.subAdministrativeArea {
                     self.locationLabel.text = city
                }
        })
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherEntryCell", for: indexPath) as? WeatherEntryTableViewCell

        print("HELLO")
        cell?.setup(data: forcastEntries![indexPath.row])
        
        return cell!
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numSections = 0
        
        
        
        for entry in forcastEntries! {
            
        }
        
        
        
        return 1//numSections
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcastEntries!.count
    }
}


