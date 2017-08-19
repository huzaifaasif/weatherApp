//
//  Constants.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-11.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "6ef554fe581dde19a163de845f0ed753"

var lat = Location.sharedInstanced.latitude!
var lon = Location.sharedInstanced.longitude!


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(String(describing: lat))\(LONGITUDE)\(Location.sharedInstanced.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstanced.latitude!)&lon=\(Location.sharedInstanced.longitude!)&appid=6ef554fe581dde19a163de845f0ed753"


