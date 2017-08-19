//
//  WeatherCell.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-16.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

/* WeatherCell.swift:
 - contains a UITableViewCell class and contains members for displaying the data in each cell
 - contains a function that sets the UI based on the provided values 
 */

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!

    func configureCell(forecast:Forecast){
        dayLabel.text = forecast.day
        minTemp.text = "\(forecast.lowTemp)"
        maxTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
    
}
