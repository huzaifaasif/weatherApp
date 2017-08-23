//
//  Forecast.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-14.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

/* Forecast.swift:
 - contains a class that stores the members for displaying forecast data
 - init function that initializes the members of the class based on the object passed in as a parameter
 */

import UIKit
import Alamofire

class Forecast{
    
    var _day:String!
    var _weatherType:String!
    var _highTemp:String!
    var _lowTemp:String!
    var _forecastArray = [Forecast]()
    
    init(dict: Dictionary<String,AnyObject>){
        
        if let temp = dict["temp"] as? Dictionary<String, AnyObject>{
            
            if let min = temp["min"] as? Double{
                let kelvinToCelcius = min - 273.15
                
                let kelvinToCelciusRoundedOff = Double(round(10 * kelvinToCelcius/10))
                self._lowTemp = "\(kelvinToCelciusRoundedOff)"
            }
            
            if let max = temp["max"] as? Double{
                 let kelvinToCelcius = max - 273.15
                 let kelvinToCelciusRoundedOff = Double(round(10 * kelvinToCelcius/10))
                self._highTemp = "\(kelvinToCelciusRoundedOff)"
            }
        }   //end of "temp"
        
        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                _weatherType = main
            }
        }
        
        if let date = dict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat =  "EEEE"
            dateFormatter.timeStyle = .none
            
            self._day = unixConvertedDate.dayOfTheWeek()
            
        }
        
        
    }
    
    
    var day:String{
        
        return _day

    }
    
    var weatherType:String{

        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp:String{
       if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp:String{
    
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    var forecastCount:Int{
        return _forecastArray.count
    }
    
    func getForecastArray(index:Int)->Forecast{
        return _forecastArray[index]
    }
    
    // Forecast weather parsing
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result        //result holds the data in JSON format
            
            if let dictionary = result.value as? Dictionary<String,AnyObject>{ //casting it as Dictionary
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]{
                    
                    print ("\n\n")
                    
                    //initializing cells with respective data
                    
                    for obj in list {        // list = array of dictionary
                        let forecast = Forecast(dict: obj)
                        self._forecastArray.append(forecast)
                        
                        
                        print(obj)
                        // print("====>Day is: \(forecast.day)")
                        // print ("-------------------------\n")
                    }
                    self._forecastArray.remove(at: 0)      //first index contains current weather data
                    
                    //tableView.reloadData()
                    
                }
            }
            
            print("===> ForecastCount: \(self.forecastCount)")
            completed()
        }
        
        
    }
    
}




extension Date {
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}



