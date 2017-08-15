//
//  WeatherVC.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-04.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather:CurrentWeather!
    var forecast:Forecast!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(CURRENT_WEATHER_URL)
        currentWeather = CurrentWeather()
        //forecast = Forecast()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateUI() // called when downloadWeatherDetails() & downloadForecastData are completed()
                
            }
           
        }
       
    }
    //Forecast weather parsing
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dictionary = result.value as? Dictionary<String,AnyObject>{  //dictionary = collection
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]{
                    
                    print ("\n\n")
                    
                    for obj in list {
                        let forecast = Forecast(dict: obj)
                        self.forecastArray.append(forecast)
                        
                        print(obj)
                        print("====>Date is: \(forecast.day)")
                        print ("-------------------------\n")
                    }
                }
            }
            completed()
        }
        
    
    }


    
    func updateUI(){
        
        locationLabel.text = currentWeather.cityName
        dateLabel.text = currentWeather.date
        currentWeatherType.text = currentWeather.weatherType
        currentTemperature.text = "\(currentWeather.currentTemp)"
        //currentTemperature.text = "44.4"
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
        
    }

  


}

