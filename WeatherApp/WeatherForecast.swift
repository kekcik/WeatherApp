//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 22.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation
import UIKit


class WeatherForecast {
    let cityName: String
    let currentTemperature: Double?
    let rainProbability: Double?
    let timestamp: Double?
    let imageName: String
    let locationCoordinates: (Double, Double)?
    
    init (cityName: String, currentTemperature: Double?, rainProbability: Double?, timestamp: Double?, imageName: String, locationCoordinates: (Double, Double)?
        ) {
        self.cityName = cityName
        self.currentTemperature = currentTemperature
        self.rainProbability = rainProbability
        self.timestamp = timestamp
        self.imageName = imageName
        self.locationCoordinates = locationCoordinates
    }
}
