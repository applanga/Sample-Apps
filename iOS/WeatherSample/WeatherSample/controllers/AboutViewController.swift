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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = NSLocalizedString("about_title", comment: "")
        self.navigationController?.title = NSLocalizedString("about_title", comment: "")
        // loading local html file
        let url = Bundle.main.url(forResource: "about-page", withExtension: "html")
        webView.load(URLRequest(url: url!))
    }
}
