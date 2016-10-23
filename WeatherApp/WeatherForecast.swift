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
    let rainProbability: Int?
    let sunTime: (Int, Int)?
    let imageName: String
    let wind: (Double, Double)?
    
    init (cityName: String, currentTemperature: Double?, rainProbability: Int?, sunTime: (Int, Int)?, imageName: String, wind: (Double, Double)?
        ) {
        self.cityName = cityName
        self.currentTemperature = currentTemperature
        self.rainProbability = rainProbability
        self.sunTime = sunTime
        self.imageName = imageName
        self.wind = wind
    }
}
