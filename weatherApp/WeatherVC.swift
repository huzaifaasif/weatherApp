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
   
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!  //an object that contains the current lat, lon...
    
   
    
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
    
  
   
    func reloadData(){
        self.tableView.reloadData()
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
                self.forecast.downloadForecastData {
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
        return forecast.forecastCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            
            cell.configureCell(forecast: forecast.getForecastArray(index: indexPath.row))    //loading respective cells with data
            
            return cell
            
        }
        
        return WeatherCell()
        
    }

  


}

