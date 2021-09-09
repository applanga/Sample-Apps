//
//  WebView.swift
//  ios-sdk
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {

        let wconfiguration = WKWebViewConfiguration()
        let webView =  WKWebView(frame: .zero, configuration: wconfiguration)

        let theFileName = ("about-page" as NSString).lastPathComponent
        let htmlPath = Bundle.main.path(forResource: theFileName, ofType: "html")

        let baseUrl = URL(fileURLWithPath: Bundle.main.bundlePath, isDirectory: true)

        do {
            let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)

            webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
        } catch {

        }

        return webView
    }
        
   func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {}
}


