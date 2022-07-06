//
//  AboutViewController.swift
//  WeatherSample
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        
        self.navigationItem.title = NSLocalizedString("daily_title", comment: "")
        self.navigationController?.title = NSLocalizedString("daily_title", comment: "")
        self.navigationItem.isAccessibilityElement = true
        self.navigationController?.isAccessibilityElement = true
    }
    
    func createObservers() {
        let updateNavTitleName = Notification.Name(rawValue: Keys.updateNavigationTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(AboutViewController.updateNavTitle), name: updateNavTitleName, object: nil)
    }
    
    @objc func updateNavTitle() {
        self.navigationItem.title = NSLocalizedString("about_title", comment: "")
        self.navigationController?.title = NSLocalizedString("about_title", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = NSLocalizedString("about_title", comment: "")
        self.navigationController?.title = NSLocalizedString("about_title", comment: "")
        // loading local html file
        let url = Bundle.main.url(forResource: "about-page", withExtension: "html")
        webView.load(URLRequest(url: url!))
    }
}
