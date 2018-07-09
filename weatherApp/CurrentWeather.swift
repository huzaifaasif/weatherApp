//
//  CurrentWeather.swift
//  weatherApp
//

/* CurrentWeather.swift:
- Contains the class that stores the members for displaying the current weather info
- Makes a request to the provided URL and pulls the response in JSON format
*/
 
import UIKit
import Alamofire

class CurrentWeather{
    
    private var _cityName:String!
    private var _date:String!
    private var _weatherType:String!
    private var _currentTemp:Double!
    
    var cityName:String{
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date:String{
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        
        self._date = "Today, \(currentDate)"
        
        return _date
        
    }
    
    var weatherType:String{
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp:Double{
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    // -----pulling the current weather data from the API and setting values-------
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in     //network call
            
            let result = response.result
            
            
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                //city name
                if let name = dictionary["name"] as? String{
                    self._cityName = name.capitalized
                    
                    print("\n\nCity Name: \(self.cityName)")
                }
                
                //weather type
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        
                        
                        print("Weather Type: \(self.weatherType)")
                    }
                }
                //current temp
                if let main = dictionary["main"] as? Dictionary<String, AnyObject>{
                    if let currentTemp = main["temp"] as? Double{
                        
                        let kelvinToCelciusPreDiv = currentTemp - 273.15
                        
                        
                        print(kelvinToCelciusPreDiv)
                        let kelvinToCelcius = Double(round(10 * kelvinToCelciusPreDiv/10)) //rounding off
                        print(kelvinToCelcius)
                        self._currentTemp = kelvinToCelcius
                        
                    }
                }
                
            }
            
            completed()              //indicating parsing has been done
            
        }
        
        
    }


}
