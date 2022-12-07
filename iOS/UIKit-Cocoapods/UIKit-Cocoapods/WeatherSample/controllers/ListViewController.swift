//
//  ListViewController.swift
//  WeatherSample
//

import UIKit
import Applanga

class ListViewController: UIViewController {
    
    let state = AppState.shared
    var displayedDaysNum: Int = 0
    
    var days = [Day]()
    
    @IBOutlet weak var displayedDays: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    func applyScreenLocalization() {
        title = NSLocalizedString("daily_title", comment: "")
        navigationItem.title = NSLocalizedString("daily_title", comment: "")
        navigationController?.title = NSLocalizedString("daily_title", comment: "")
    }
}

extension ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyScreenLocalization()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.displayedDaysNum = AppSettings().getDisplayedDays()!
        
        self.navigationItem.title = NSLocalizedString("daily_title", comment: "")
        self.navigationController?.title = NSLocalizedString("daily_title", comment: "")
        
        displayedDays.text = NSString.localizedStringWithFormat(NSString(string:(Applanga.localizedString(forKey: "daily_displayed_days", withDefaultValue: "Days display", andArguments: nil, andPluralRule: ALPluralRuleForQuantity(UInt(displayedDaysNum))))), displayedDaysNum) as String
        
        days = getDays()
        tableView.reloadData()
    }
}

extension ListViewController {
    @objc func handleLanguageChanged() {
        applyScreenLocalization()
    }
    
    @objc func handleWeatherChanged() {
        tableView.reloadData()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLanguageChanged),
                                               name: .userLanguageChanged,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLanguageChanged),
                                               name: .userLanguageChanged,
                                               object: nil)
    }
    
    func getDays() -> [Day] {
        let displayedDaysNumber = self.displayedDaysNum * 8
        return Array(state.dailyWeather!.list.prefix(displayedDaysNumber))
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = days[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell") as! DayCell
        
        cell.configCell(day: day)
        return cell
    }
}
