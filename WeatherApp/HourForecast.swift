//
//  HourForecast.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 23.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation

class HourForecast {
    let arrayForecast: [WeatherForecast]
    init (arrayForecast: [WeatherForecast]) {
        self.arrayForecast = arrayForecast
    }
}
