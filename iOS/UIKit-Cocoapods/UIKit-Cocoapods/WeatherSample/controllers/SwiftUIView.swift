//
//  SwiftUIView.swift
//  WeatherSample
//
//  Created by Simon Borkin on 26/5/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State var full: Bool = false
    var body: some View {
        Text("Hello, World!").onTapGesture {
            full = true
        }
        .sheet(isPresented: $full) {
            MyView()
            
        }
    }
}

struct MyView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
