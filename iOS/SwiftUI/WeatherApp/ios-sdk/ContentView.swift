//
//  ContentView.swift
//  ios-sdk
//
import SwiftUI

struct ContentView: View {
    
    @StateObject var state = AppState()
    @State var currentView = Views.home
    @State var isNavBarOpen = false
    
    init() {
        AppSettings().initSettings()
    }
    
    var body: some View {
        
        let closeMenuDrag = DragGesture()
            .onEnded {
                if (self.isNavBarOpen && $0.translation.width < -100) {
                    withAnimation {
                        self.isNavBarOpen = false
                    }
                }
            }
        
        
        return NavigationView {
            ZStack {
                if (currentView == Views.home) {
                    HomeView()
                }
                
                else if (currentView == Views.daily) {
                    DailyView()
                }
                
                else if (currentView == Views.settings) {
                    SettingsView(goHome: self.goToHome)
                }
                
                else if (currentView == Views.about) {
                    AboutView()
                }
                
                if (self.isNavBarOpen) {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .animation(.easeInOut(duration: 1))
                }
                
                HStack {
                    if (self.isNavBarOpen) {
                        NavMenuView(
                            currentView: self.currentView,
                            goToHome: self.goToHome,
                            goToDaily: self.goToDaily,
                            goToAbout: self.goToAbout,
                            goToSettings: self.goToSettings
                        )
                        .transition(.move(edge: .leading))
                    }
                                        
                    Spacer()
                }
            }
            .gesture(closeMenuDrag)
            .navigationBarTitle(LocalizedStringKey(self.currentView.rawValue), displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.isNavBarOpen.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                }
                .accessibility(identifier: "hamburgerBtn")
            ))
        }
        .environmentObject(state)
        .onAppear {
            // call API
            Repository().getCurrentWeather { (CurrentWeatherDataModel) in
                    self.state.currentWeatherData = CurrentWeatherDataModel
            }
            
            Repository().getDailyWeather { (DailyWeatherDataModel) in
                self.state.dailyWeatherData = DailyWeatherDataModel
            }
        }
    }
    
    func goToView(view: Views) {
        self.currentView = view
        self.isNavBarOpen = false
    }
    
    func goToHome() {
        goToView(view: .home)
    }
    
    func goToDaily() {
        goToView(view: .daily)
    }
    
    func goToAbout() {
        goToView(view: .about)
    }
    
    func goToSettings() {
        goToView(view: .settings)
    }
    
}

enum Views: String {
    case home = "home_title"
    case daily = "daily_title"
    case settings = "settings_title"
    case about = "about_title"
}
