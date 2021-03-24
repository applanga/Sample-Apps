//
//  WeatherImageView.swift
//  ios-sdk
//

import SwiftUI

struct WeatherImageView: View {
    
    let iconCode: String;
    
    var body: some View {
        switch iconCode {
            case "01d": return AnyView(
                    Image(systemName: "sun.max.fill")
                    .renderingMode(.original)
                )
            case "01n": return AnyView(
                Image(systemName: "moon.fill")
                    .foregroundColor(Color(.systemGray3))
            )
            case "02d", "02n": return AnyView(
                Image(systemName: "cloud.sun.fill")
                    .renderingMode(.original)
            )
            case "03d", "03n": return AnyView(
                Image(systemName: "cloud.fill")
                    .renderingMode(.original)
            )
            case "04d", "04n": return AnyView(
                Image(systemName: "smoke.fill")
                    .renderingMode(.original)
            )
            case "09d", "09n": return AnyView(
                Image(systemName: "cloud.drizzle.fill")
                    .renderingMode(.original)
                
            )
            case "10d", "10n": return AnyView(
                Image(systemName: "cloud.heavyrain.fill")
                    .renderingMode(.original)
            )
            case "11d", "11n": return AnyView(
                Image(systemName: "cloud.bolt.rain.fill")
                    .renderingMode(.original)
            )
            case "13d", "13n": return AnyView(
                Image(systemName: "cloud.snow.fill")
                    .renderingMode(.original)
            )
            case "50d", "50n": return AnyView(
                Image(systemName: "wind")
                    .foregroundColor(.gray)
            )
        default:
            return
                AnyView(Image(systemName: "cloud.sun.fill")
                            .renderingMode(.original))
        }
    }
}

struct WeatherImageView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherImageView(iconCode: "02n")
            .font(.system(size: 150))
    }
}
