//
//  SettingsViewController.swift
//  WeatherSample
//

import UIKit
import DropDown
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
    @IBOutlet weak var selectedLanguage: UIButton!
    @IBOutlet weak var displayedDaysTitle: UILabel!
    @IBOutlet weak var displayedDaysSlider: UISlider!
    @IBOutlet weak var sliderValueTitle: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var imperialButton: UIButton!
    @IBOutlet weak var metricTitle: UILabel!
    @IBOutlet weak var imperialTitle: UILabel!
    @IBOutlet weak var box1: UIView!
    @IBOutlet weak var box2: UIView!
    @IBOutlet weak var box3: UIView!
    @IBOutlet weak var box4: UIView!
    @IBOutlet weak var box5: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        box1.layer.cornerRadius = 15
        box2.layer.cornerRadius = 15
        box3.layer.cornerRadius = 15
        box4.layer.cornerRadius = 15
        box5.layer.cornerRadius = 15
        
        configActions()
        configDropdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorText.isHidden = true
        configUi()
    }
    
    func saveSettings() {
        let prevLocation = AppSettings().getLocation()!
        errorText.isHidden = true
        
        // save to settings
        AppSettings().setLocation(location: self.location)
        AppSettings().setUnits(units: self.units)
        AppSettings().setLanguage(language: self.language)
        AppSettings().setDisplayedDays(displayedDays: self.displayedDays)
        
        Repository().getCurrentWeather { (response) in
            if (response == nil) {
                self.errorText.isHidden = false
                AppSettings().setLocation(location: prevLocation)
                return
            }
            
            self.state.setCurrentWeather(currentWeather: response!)

            Repository().getDailyWeather { (response) in
                if (response != nil) {
                    self.state.setDailyWeather(dailyWeather: response!)
                }
            }
            
            // applanga change language
            var isoCode: String
            switch self.language {
            case "German":
                isoCode = "de"
            case "French":
                isoCode = "fr"
            default:
                isoCode = "en"
            }
            Applanga.setLanguage(isoCode)
            
            // refresh page
            self.performSegue(withIdentifier: "refresh", sender: nil)
            self.dismiss(animated: true, completion:nil)
        }
    }
    
    func configUi() {
        self.navigationItem.title = NSLocalizedString("settings_title", comment: "")
        self.navigationController?.title = NSLocalizedString("settings_title", comment: "")
        
        errorText.text = NSLocalizedString("settings_error_warning", comment: "")
        
        locationTitle.text = NSLocalizedString("settings_location", comment: "")
        locationInput.text = self.location
        locationInput.borderStyle = .none
        
        unitTitle.text = NSLocalizedString("settings_measurement_unit", comment: "")
        metricTitle.text = NSLocalizedString("settings_metric_option", comment: "")
        imperialTitle.text = NSLocalizedString("settings_imperial_option", comment: "")
        
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
        
        languageTitle.text = NSLocalizedString("settings_language", comment: "")
        var lang: String
        switch (self.language) {
            case "German": lang = NSLocalizedString("settings_app_language[1]", comment: "")
            case "French": lang = NSLocalizedString("settings_app_language[2]", comment: "")
            default: lang = NSLocalizedString("settings_app_language[0]", comment: "")
        }
        selectedLanguage.setTitle(lang, for: .normal)
        
        displayedDaysTitle.text = NSLocalizedString("settings_displayed_days", comment: "")
        self.sliderValueTitle.text = String(displayedDays)
        self.displayedDaysSlider.value = Float(self.displayedDays)
        
        saveButton.setTitle(NSLocalizedString("settings_save_button", comment: ""), for: .normal)
        
        dropDown.dataSource = [
            NSLocalizedString("settings_app_language[0]", comment: ""),
            NSLocalizedString("settings_app_language[1]", comment: ""),
            NSLocalizedString("settings_app_language[2]", comment: "")
        ]
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
    
    // dropdown
    let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = [
            NSLocalizedString("settings_app_language[0]", comment: ""),
            NSLocalizedString("settings_app_language[1]", comment: ""),
            NSLocalizedString("settings_app_language[2]", comment: "")
        ]
        return dropDown
    }()
    
    func configDropdown() {
        dropDown.anchorView = selectedLanguage
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTap))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        selectedLanguage.addGestureRecognizer(gesture)
        selectedLanguage.tintColor = .black
        
        dropDown.selectionAction = { index, title in
            var lang: String
            switch (index) {
                case 1: lang = "German"
                case 2: lang = "French"
                default: lang = "English"
            }
            self.language = lang
            self.selectedLanguage.setTitle(NSLocalizedString("settings_app_language[\(index)]", comment: ""), for: .normal)
        }
    }
    
    @objc func dropdownTap() {
        dropDown.show()
    }
}



