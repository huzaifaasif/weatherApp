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

let lat = 49.249660
let lon = -123.119339


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(lat)&lon=\(lon)&appid=6ef554fe581dde19a163de845f0ed753"


