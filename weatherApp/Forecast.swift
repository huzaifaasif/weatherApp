//
//  Forecast.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-14.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    
    var _day:String!
    var _weatherType:String!
    var _highTemp:String!
    var _lowTemp:String!
    
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
    
    
    var day:String{        //returns the da
        
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
    
}


extension Date {
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}



