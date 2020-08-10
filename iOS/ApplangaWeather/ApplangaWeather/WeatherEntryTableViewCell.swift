//
//  WeatherEntryTableViewCell.swift
//  ApplangaWeather
//
//  Created by Richard Elms on 10.08.20.
//  Copyright © 2020 Richard Elms. All rights reserved.
//

import UIKit

class WeatherEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var TempLabel: UILabel!
    
    @IBOutlet weak var IconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(data : weatherEntry)
    {
        
        var time = Date(timeIntervalSince1970: data.dt)
        var calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        
        
        TimeLabel.text = String(format: "%02d:%02d", hour,minute)
        TempLabel.text = String(format: "%.0f°C",data.main.temp)
        WeatherGetter.getWeatherIcon(iconName: data.weather[0].icon) { image in
            self.IconImage.image = image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
