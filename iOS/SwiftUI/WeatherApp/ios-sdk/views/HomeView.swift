//
//  HomeView.swift
//  ios-sdk
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var state: AppState
    
    let location = AppSettings().getLocation()!
    
    var body: some View {
        
        if (state.currentWeatherData == nil) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(x: 3, y: 3, anchor: .center)
        } else {
            
            ScrollView {
                VStack {
                    
                    // Location
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .renderingMode(.template)
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                        
                        Text("\(location), \((state.currentWeatherData?.sys.country)!)")
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(Color("textGray"))
                    }
                    .padding(.top, 20)
                    
                    // Date
                    Text(getTodayDate())
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .lineLimit(1)
                    
                    // Temperature
                    Text("\(Int(round((state.currentWeatherData?.main.temp)!)))°")
                        .font(.system(size: 85))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    WeatherImageView(iconCode: (state.currentWeatherData?.weather[0].icon)!)
                        .font(.system(size: 140))
                        .padding(.bottom, 30)
                        .shadow(radius: 15)
                    
                    // Details
                    VStack {
                        
                        HomeDetailView(
                            title: "home_description",
                            content: (getWeatherDesc(iconCode: (state.currentWeatherData?.weather[0].icon)!)))
                        
                        HomeDetailView(
                            title: "home_humidity",
                            content: "\((state.currentWeatherData?.main.humidity)!)%")
                        
                        HomeDetailView(
                            title: "home_wind_speed",
                            content: String((state.currentWeatherData?.wind.speed)!) + " km/h")

                        HomeDetailView(
                            title: "home_feels_like",
                            content: "\(Int(round((state.currentWeatherData?.main.feelsLike)!)))°")
                        
                        HomeDetailView(
                            title: "home_clouds",
                            content: String((state.currentWeatherData?.clouds.all)!) + "%")
                        
                        HomeDetailView(
                            title: "home_pressure",
                            content: String((state.currentWeatherData?.main.pressure)!) + " hPa")
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 10)

            }
            .background(LinearGradient(
                gradient: Gradient(
                    colors: [Color("Applanga"), Color("ApplangaDark")]

                ), startPoint: .top, endPoint: .bottom
            ))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
