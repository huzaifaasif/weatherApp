//
//  Location.swift
//  weatherApp
//
//  Created by Huzaifa Asif on 2017-08-16.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

//Singleton class - can be instantiated only once (single copy)
import CoreLocation

class Location{
    
    static var sharedInstanced = Location()
    var latitude:Double!
    var longitude:Double!
}
