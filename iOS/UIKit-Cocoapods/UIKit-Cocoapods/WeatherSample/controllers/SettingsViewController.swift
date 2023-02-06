//
//  SettingsViewController.swift
//  WeatherSample
//

import UIKit
import Applanga

class SettingsViewController: UIViewController {
    let state = AppState.shared
    
    var location = AppSettings().getLocation()!
    var units = AppSettings().getUnits()!
    var language = AppSettings().getLanguage()!
    var displayedDays = AppSettings().getDisplayedDays()!
    
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var unitTitle: UILabel!
    @IBOutlet weak var languageTitle: UILabel!
    @IBOutlet weak var langEn: UIButton!
    @IBOutlet weak var langDe: UIButton!
    @IBOutlet weak var langFr: UIButton!
    @IBOutlet weak var displayedDaysTitle: UILabel!
    @IBOutlet weak var displayedDaysSlider: UISlider!
    @IBOutlet weak var sliderValueTitle: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var imperialButton: UIButton!
    @IBOutlet weak var box1: UIView!
    @IBOutlet weak var box2: UIView!
    @IBOutlet weak var box3: UIView!
    @IBOutlet weak var box4: UIView!
    @IBOutlet weak var loadingView: UIView!

    func applyScreenLocalization() {
        title = NSLocalizedString("settings_title", comment: "")
        navigationItem.title = NSLocalizedString("settings_title", comment: "")
        navigationController?.title = NSLocalizedString("settings_title", comment: "")
        
        errorText.text = NSLocalizedString("settings_error_warning", comment: "")
        
        locationTitle.text = NSLocalizedString("settings_location", comment: "")
        
        unitTitle.text = NSLocalizedString("settings_measurement_unit", comment: "")
        metricButton.setTitle(NSLocalizedString("settings_metric_option", comment: ""), for: .normal)
        imperialButton.setTitle(NSLocalizedString("settings_imperial_option", comment: ""), for: .normal)
        
        languageTitle.text = NSLocalizedString("settings_language", comment: "")
        
        langEn.setTitle(NSLocalizedString("settings_app_language[0]", comment: ""), for: .normal)
        langDe.setTitle(NSLocalizedString("settings_app_language[1]", comment: ""), for: .normal)
        langFr.setTitle(NSLocalizedString("settings_app_language[2]", comment: ""), for: .normal)
        
        displayedDaysTitle.text = NSLocalizedString("settings_displayed_days", comment: "")
        saveButton.setTitle(NSLocalizedString("settings_save_button", comment: ""), for: .normal)
    }
    
    func performLanguageChange(completion: @escaping ()->()) {
        var isoCode: String
        switch self.language {
        case "German":
            isoCode = "de"
        case "French":
            isoCode = "fr"
        default:
            isoCode = "en"
        }
        
        Applanga.setLanguageAndUpdate(isoCode) { [weak self] success in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                success ? completion() : self?.handleLanguageUpdateError()
            }
        }
    }
    
    func handleLanguageUpdateError() {
        errorText.isHidden = false
        errorText.text = NSLocalizedString("settings_error_warning", comment: "")
    }
}

extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyScreenLocalization()
        configActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorText.isHidden = true
        configUi()
    }
}

extension SettingsViewController {
    func saveSettings() {
        let prevLocation = AppSettings().getLocation()!
        errorText.isHidden = true
        
        // save to settings
        AppSettings().setLocation(location: self.location)
        AppSettings().setUnits(units: self.units)
        AppSettings().setLanguage(language: self.language)
        AppSettings().setDisplayedDays(displayedDays: self.displayedDays)
        
        Repository().getCurrentWeather { [weak self] response in
            guard let self = self else { return }
            
            guard let response = response else {
                self.errorText.isHidden = false
                AppSettings().setLocation(location: prevLocation)
                return
            }
            
            self.state.setCurrentWeather(currentWeather: response)

            Repository().getDailyWeather { [weak self] response in
                if let response = response {
                    self?.state.setDailyWeather(dailyWeather: response)
                }
            }
            
            self.loadingView.isHidden = false

            self.performLanguageChange { [weak self] in
                guard let self = self else { return }
                
                self.loadingView.isHidden = true
                self.applyScreenLocalization()
                
                // refresh page
                self.performSegue(withIdentifier: "refresh", sender: nil)
                self.dismiss(animated: true, completion:nil)
                
                NotificationCenter.default.post(name: .userLanguageChanged, object: nil)
            }
        }
    }
    
    func configUi() {
        box1.layer.cornerRadius = 15
        box2.layer.cornerRadius = 15
        box3.layer.cornerRadius = 15
        box4.layer.cornerRadius = 15
        
        locationInput.text = self.location
        locationInput.borderStyle = .none
        
        metricButton.tintColor = .black
        metricButton.setTitle("", for: .normal)
        imperialButton.tintColor = .black
        imperialButton.setTitle("", for: .normal)
        
        if (units == "Metric") {
            metricButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            imperialButton.setImage(UIImage(systemName: "circle"), for: .normal)
            metricButton.tintColor = .systemBlue
            imperialButton.tintColor = .black
        } else {
            metricButton.setImage(UIImage(systemName: "circle"), for: .normal)
            imperialButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            imperialButton.tintColor = .systemBlue
            metricButton.tintColor = .black
        }
        
        metricButton.setTitle(NSLocalizedString("settings_metric_option", comment: ""), for: .normal)
        imperialButton.setTitle(NSLocalizedString("settings_imperial_option", comment: ""), for: .normal)
  
        langEn.tintColor = .black
        langDe.tintColor = .black
        langFr.tintColor = .black

        switch (language) {
            case "German": langDe.tintColor = .systemBlue
            case "French": langFr.tintColor = .systemBlue
            default: langEn.tintColor = .systemBlue
        }
        
        sliderValueTitle.text = String(displayedDays)
        displayedDaysSlider.value = Float(self.displayedDays)
    }
    
    func configActions() {
        // location
        locationInput.addAction(UIAction(handler: { action in
            self.location = self.locationInput.text!
        }), for: .editingChanged)
        
        // units
        metricButton.addAction(UIAction(handler: { action in
            self.metricButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            self.metricButton.tintColor = .systemBlue
            self.imperialButton.setImage(UIImage(systemName: "circle"), for: .normal)
            self.imperialButton.tintColor = .black
            self.units = "Metric"
        }), for: .touchUpInside)
        
        imperialButton.addAction(UIAction(handler: { action in
            self.metricButton.setImage(UIImage(systemName: "circle"), for: .normal)
            self.metricButton.tintColor = .black
            self.imperialButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
            self.imperialButton.tintColor = .systemBlue
            self.units = "Imperial"
        }), for: .touchUpInside)
        
        // language
        langEn.addAction(UIAction(handler: { action in
            self.language = "English"
            self.langEn.tintColor = .systemBlue
            self.langDe.tintColor = .black
            self.langFr.tintColor = .black
        }), for: .touchUpInside)
        
        langDe.addAction(UIAction(handler: { action in
            self.language = "German"
            self.langEn.tintColor = .black
            self.langDe.tintColor = .systemBlue
            self.langFr.tintColor = .black
        }), for: .touchUpInside)
        
        langFr.addAction(UIAction(handler: { action in
            self.language = "French"
            self.langEn.tintColor = .black
            self.langDe.tintColor = .black
            self.langFr.tintColor = .systemBlue
        }), for: .touchUpInside)

        // displayed days
        displayedDaysSlider.addAction(UIAction(handler: { action in
            let numOfDays = Int(round(self.displayedDaysSlider.value))
            self.sliderValueTitle.text = String(numOfDays)
            self.displayedDays = numOfDays
        }), for: .valueChanged)
        
        // save button
        saveButton.addAction(UIAction(handler: { action in
            self.saveSettings()
        }), for: .touchUpInside)
    }
}
