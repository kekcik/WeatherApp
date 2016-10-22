//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 22.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation

class WeatherForecast {
    let currentWeatherTemperature: Double?
    let rainProbability: Double?
    let timestamp: Double
    let imageName: String
    let locationCoordinates: (Double, Double)?
    
    init(currentWeatherTemperature: Double?, rainProbability: Double?, timestamp: Double, imageName: String, locationCoordinates: (Double, Double)?) {
        self.currentWeatherTemperature = currentWeatherTemperature
        self.rainProbability = rainProbability
        self.timestamp = timestamp
        self.imageName = imageName
        self.locationCoordinates = locationCoordinates
    }
}
