//
//  HomeViewController.swift
//  WeatherSample
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    let state = AppState.shared
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var feelsLikeTitle: UILabel!
    @IBOutlet weak var feelsLikeValue: UILabel!
    @IBOutlet weak var humidityTitle: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var cloudsTitle: UILabel!
    @IBOutlet weak var cloudsValue: UILabel!
    @IBOutlet weak var windSpeedTitle: UILabel!
    @IBOutlet weak var windSpeedValue: UILabel!
    @IBOutlet weak var pressureTitle: UILabel!
    @IBOutlet weak var pressureValue: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func applyBaseLocalization() {
        navigationItem.title = NSLocalizedString("home_title", comment: "")
        navigationController?.title = NSLocalizedString("home_title", comment: "")
        
        descriptionTitle.text = NSLocalizedString("home_description", comment: "")
        feelsLikeTitle.text = NSLocalizedString("home_feels_like", comment: "")
        humidityTitle.text = NSLocalizedString("home_humidity", comment: "")
        cloudsTitle.text = NSLocalizedString("home_clouds", comment: "")
        windSpeedTitle.text = NSLocalizedString("home_wind_speed", comment: "")
        pressureTitle.text = NSLocalizedString("home_pressure", comment: "")
    }
    
    func applyWeatherStateLocalization() {
        temperature.text = ("\(Int(round((state.currentWeather?.main.temp)!)))°")
        date.text = getTodayDate()
        location.text = "\((state.currentWeather?.name)!), \(state.currentWeather?.sys.country ?? "")"
        feelsLikeValue.text = "\(Int(round((state.currentWeather?.main.feelsLike)!)))°"
        humidityValue.text = "\((state.currentWeather?.main.humidity)!)%"
        cloudsValue.text = "\((state.currentWeather?.clouds.all)!)%"
        windSpeedValue.text = "\((state.currentWeather?.wind.speed)!) km/h"
        pressureValue.text = "\((state.currentWeather?.main.pressure)!) hPa"
        
        let iconId = (state.currentWeather?.weather[0].icon)!
        descriptionValue.text = getWeatherDesc(iconCode: iconId)
    }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createObservers()
        applyBaseLocalization()
        configBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (state.currentWeather == nil) {
            configState()
        } else {
            updateUi()
        }
    }
}

extension HomeViewController {
    @objc func updateUi() {
        applyWeatherStateLocalization()

        let iconId = (state.currentWeather?.weather[0].icon)!
        weatherIcon.image = UIImage(systemName: getWeatherIcon(iconCode: iconId))
        getIconColor(iconCode: iconId, img: weatherIcon)
        weatherIcon.layer.shadowColor = UIColor.black.cgColor
        weatherIcon.layer.shadowOpacity = 0.5
        weatherIcon.layer.shadowOffset = CGSize.zero
        weatherIcon.layer.shadowRadius = 8
        
        loadingView.isHidden = true
    }
    
    func configState() {
        Repository().getCurrentWeather { (response) in
            if (response == nil) {
                return
            }
            
            self.state.setCurrentWeather(currentWeather: response!)
        }
        
        Repository().getDailyWeather { (response) in
            self.state.dailyWeather = response
        }
    }
     
    func configBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func createObservers() {
    }
}
