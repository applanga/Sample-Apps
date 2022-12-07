//
//  AboutViewController.swift
//  WeatherSample
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    func applyScreenLocalization() {
        title = NSLocalizedString("about_title", comment: "")
        navigationItem.title = NSLocalizedString("about_title", comment: "")
        navigationController?.title = NSLocalizedString("about_title", comment: "")
    }
}

extension AboutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyScreenLocalization()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.isAccessibilityElement = true
        navigationController?.isAccessibilityElement = true
        
        // loading local html file
        let url = Bundle.main.url(forResource: "about-page", withExtension: "html")
        webView.load(URLRequest(url: url!))
    }
}

extension AboutViewController {
    @objc func handleLanguageChanged() {
        applyScreenLocalization()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLanguageChanged),
                                               name: .userLanguageChanged,
                                               object: nil)
    }
}
