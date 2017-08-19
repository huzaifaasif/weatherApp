//
//  WeatherVC.swift
//  weatherApp
//

/* This Weather App is designed to display the current weather along with a forecast weather for the 6 upcoming days
 
 */

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather:CurrentWeather!
    var forecast:Forecast!
    var forecastArray = [Forecast]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!  //an object contains the current lat, lon...
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use highest level of accuracy
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        currentWeather = CurrentWeather()
        
      
       
    }
    
    //Forecast weather parsing
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result        //result holds the data in JSON format
            
            if let dictionary = result.value as? Dictionary<String,AnyObject>{ //casting it as Dictionary
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]{
                    
                    print ("\n\n")
                    
                    //initializing cells with respective data
                    
                    for obj in list {                       // list = array of dictionary
                        let forecast = Forecast(dict: obj)
                        self.forecastArray.append(forecast)
                        
                        
                        print(obj)
                       // print("====>Day is: \(forecast.day)")
                       // print ("-------------------------\n")
                    }
                    self.forecastArray.remove(at: 0)      //first index contains current weather data
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    
    }
    

    func locationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location     //storing a location object
            
            Location.sharedInstanced.latitude = currentLocation.coordinate.latitude
            Location.sharedInstanced.longitude = currentLocation.coordinate.longitude
            
            print("Latitude: \(Location.sharedInstanced.latitude!), Longitude: \(Location.sharedInstanced.longitude!)")
            print("\(CURRENT_WEATHER_URL)\n")
            print("\(FORECAST_WEATHER_URL)\n")
            
            
     //making sure UI is only updated when currentWeather and forecastWeather data have been set
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateUI()
                    
                }
                
            }
        }
        else{
            locationManager.requestWhenInUseAuthorization() //requesting to use location services
            locationAuthorizationStatus() 
        }
    }
    
    func updateUI(){
        
        locationLabel.text = currentWeather.cityName
        dateLabel.text = currentWeather.date
        currentWeatherType.text = currentWeather.weatherType
        currentTemperature.text = "\(currentWeather.currentTemp)"
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    //tableview delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            
            cell.configureCell(forecast: forecastArray[indexPath.row])    //loading respective cells with data
            
            return cell
            
        }
        
        return WeatherCell()
        
    }

  


}

