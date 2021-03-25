package com.example.weatherapp.fragments

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.fragment.app.Fragment
import com.applanga.android.Applanga
import com.example.weatherapp.R


class AboutFragment : Fragment() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val htmlPath = "file:///android_asset/about-page.html"
        val view: View = inflater.inflate(R.layout.fragment_about, container, false)

        val aboutWebView = view.findViewById<View>(R.id.about_webview) as WebView
        aboutWebView.apply {
            settings.javaScriptEnabled = true
            webViewClient = WebViewClient()
            loadUrl(htmlPath)
        }
        Applanga.attachWebView(aboutWebView)

        return view
    }
}