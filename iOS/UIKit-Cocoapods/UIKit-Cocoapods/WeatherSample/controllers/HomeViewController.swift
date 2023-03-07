//
//  HomeViewController.swift
//  WeatherSample
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    let state = AppState.shared
    var baseFont: UIFont?
    
    @IBOutlet var location: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var descriptionTitle: UILabel!
    @IBOutlet var descriptionValue: UILabel!
    @IBOutlet var feelsLikeTitle: UILabel!
    @IBOutlet var feelsLikeValue: UILabel!
    @IBOutlet var humidityTitle: UILabel!
    @IBOutlet var humidityValue: UILabel!
    @IBOutlet var cloudsTitle: UILabel!
    @IBOutlet var cloudsValue: UILabel!
    @IBOutlet var windSpeedTitle: UILabel!
    @IBOutlet var windSpeedValue: UILabel!
    @IBOutlet var pressureTitle: UILabel!
    @IBOutlet var pressureValue: UILabel!
    @IBOutlet var loadingView: UIView!

    func applyScreenLocalization() {
        title = NSLocalizedString("home_title", comment: "")
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
        
        weatherIcon.image = UIImage(systemName: getWeatherIcon(iconCode: iconId))
        getIconColor(iconCode: iconId, img: weatherIcon)
    }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseFont = descriptionValue.font
        
        applyScreenLocalization()
        configBackground()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.isHidden = true
        if (state.currentWeather == nil) {
            configState()
        } else {
            updateUi()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        alignFontSize()
    }
}

extension HomeViewController {
    @objc func handleLanguageChanged() {
        applyScreenLocalization()
        applyWeatherStateLocalization()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc func handleWeatherUpdated() {
        let iconId = (state.currentWeather?.weather[0].icon)!
        weatherIcon.image = UIImage(systemName: getWeatherIcon(iconCode: iconId))
        getIconColor(iconCode: iconId, img: weatherIcon)
        
        applyWeatherStateLocalization()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func updateUi() {
        weatherIcon.layer.shadowColor = UIColor.black.cgColor
        weatherIcon.layer.shadowOpacity = 0.5
        weatherIcon.layer.shadowOffset = CGSize.zero
        weatherIcon.layer.shadowRadius = 8
        
        loadingView.isHidden = true
    }
    
    func configState() {
        Repository().getCurrentWeather { [weak self] response in
            guard let self = self, let response = response else {
                return
            }
            
            self.updateUi()
            self.state.setCurrentWeather(currentWeather: response)
        }
        
        Repository().getDailyWeather { [weak self] response in
            self?.state.dailyWeather = response
        }
    }
     
    func configBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func alignFontSize() {
        guard let baseFont = baseFont else { return }
        let labels = [
            descriptionValue,
            feelsLikeValue,
            humidityValue,
            cloudsValue,
            windSpeedValue,
            pressureValue
        ] as [UILabel]
        
        // After the weather state labels are auto scalled to fit, find the smallest font size, and use it for all labels
        let smallestSize = labels.map { $0.adjustedFont(baseFont).pointSize }.min { $0 < $1 } ?? descriptionValue.adjustedFont(baseFont).pointSize
        labels.forEach { $0.font = descriptionValue.font.withSize(smallestSize) }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLanguageChanged),
                                               name: .userLanguageChanged,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWeatherUpdated),
                                               name: .weatherUpdated,
                                               object: nil)
    }
}
