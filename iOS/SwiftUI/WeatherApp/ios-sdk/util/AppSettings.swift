//
//  AppSettings.swift
//  ios-sdk
//

import Foundation

class AppSettings {
    enum Language: String, CaseIterable {
        case english
        case german
        case french
    }
    
    enum Keys: String {
        case location = "location"
        case units = "units"
        case language = "language"
        case displayedDays = "displayedDays"
    }
    
    let settings = UserDefaults.standard
    
    public func initSettings() {
        let initialLocation = "New York"
        let initialUnits = "Metric"
        let initialLanguage = Language.english
        let initialDisplayedDays = 5
        
        if (getLocation() == nil) {
            setLocation(location: initialLocation)
        }
        
        if (getUnits() == nil) {
            setUnits(units: initialUnits)
        }
        
        if (getLanguage() == nil) {
            setLanguage(language: initialLanguage)
        }
        
        if (getDisplayedDays() == nil || getDisplayedDays() == 0) {
            setDisplayedDays(displayedDays: initialDisplayedDays)
        }
        
    }
    
    // Getters
    public func getLocation() -> String? {
        return settings.string(forKey: Keys.location.rawValue)
    }
    
    public func getUnits() -> String? {
        return settings.string(forKey: Keys.units.rawValue)
    }
    
    public func getLanguage() -> Language? {
        guard let rawValue = settings.string(forKey: Keys.language.rawValue) else { return nil }
        return Language(rawValue: rawValue)
    }
    
    public func getDisplayedDays() -> Int? {
        return settings.integer(forKey: Keys.displayedDays.rawValue)
    }
    
    // Setters
    public func setLocation(location: String) {
        settings.set(location, forKey: Keys.location.rawValue)
    }
    
    public func setUnits(units: String) {
        settings.set(units, forKey: Keys.units.rawValue)
    }
    
    public func setLanguage(language: Language) {
        settings.set(language.rawValue, forKey: Keys.language.rawValue)
    }
    
    public func setDisplayedDays(displayedDays: Int) {
        settings.set(displayedDays, forKey: Keys.displayedDays.rawValue)
    }
}
