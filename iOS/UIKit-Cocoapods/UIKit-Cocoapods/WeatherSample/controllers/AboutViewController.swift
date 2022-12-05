//
//  AboutViewController.swift
//  WeatherSample
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    func applyApplangaLocalization() {
        navigationItem.title = NSLocalizedString("about_title", comment: "")
        navigationController?.title = NSLocalizedString("about_title", comment: "")
    }
}

extension AboutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        applyApplangaLocalization()

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.isAccessibilityElement = true
        navigationController?.isAccessibilityElement = true

        // loading local html file
        let url = Bundle.main.url(forResource: "about-page", withExtension: "html")
        webView.load(URLRequest(url: url!))
    }
    
    func createObservers() {
        let updateNavTitleName = Notification.Name(rawValue: Keys.updateNavigationTitle.rawValue)
    }
}
