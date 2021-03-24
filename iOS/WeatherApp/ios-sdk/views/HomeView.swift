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
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
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
                            title: "title_description",
                            content: (getWeatherDesc(iconCode: (state.currentWeatherData?.weather[0].icon)!)))
                        
                        HomeDetailView(
                            title: "title_humidity",
                            content: "\((state.currentWeatherData?.main.humidity)!)%")
                        
                        HomeDetailView(
                            title: "title_wind_speed",
                            content: String((state.currentWeatherData?.wind.speed)!) + " km/h")

                        HomeDetailView(
                            title: "title_feels_like",
                            content: "\(Int(round((state.currentWeatherData?.main.feelsLike)!)))°")
                        
                        HomeDetailView(
                            title: "title_clouds",
                            content: String((state.currentWeatherData?.clouds.all)!) + "%")
                        
                        HomeDetailView(
                            title: "title_wind_pressure",
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
