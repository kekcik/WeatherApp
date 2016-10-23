//
//  WeatherHelper.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 22.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire

protocol WeatherHelperDelegate {
    func updateWeatherInfo()
}

class WeatherHelper {
    static func setParams(param: WeatherForecast?) {
        self.weather = param;
        print("copy success : \(self.weather?.cityName)")
    }
    static var delegate: WeatherHelperDelegate!

    static func getWeatherFor(city: String) -> WeatherForecast? {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/weather"
        let params = ["q": city, "APPID": keys.openWeatherMapApiKye]
        let str: String = "213"
        let queue = DispatchQueue(label: "com.cnoon.WeatherApp", qos: .utility, attributes: [.concurrent])
        request(weatherUrl, method: .get, parameters: params).responseJSON(queue: queue, completionHandler: { (DataResponse) in
            print(str)
            if (DataResponse.result.isFailure) {
                print("Detected Error")
            }
            if (DataResponse.result.isSuccess) {
                let weatherJson = JSON(data: DataResponse.data!)
                if let cityName = weatherJson["name"].string,
                    let currentTemperature = weatherJson["main"]["temp"].double,
                    let rainProbability = weatherJson["main"]["humidity"].int,
                    let imageName = weatherJson["weather"][0]["icon"].string,
                    let locationCoordinatesX = weatherJson["coord"]["lon"].double,
                    let locationCoordinatesY = weatherJson["coord"]["lat"].double
                {
                    print("\nParser: parsing is complete\n")
                    let d = WeatherForecast.init(cityName: cityName, currentTemperature: currentTemperature, rainProbability: Double(rainProbability), timestamp: 0, imageName: imageName, locationCoordinates: (locationCoordinatesX, locationCoordinatesY))
                    self.setParams(param: d)
                    
                } else {
                    print("\nError: parsing failed\n")
                }
                
                
            }
            print(self.weather?.cityName)
        })
        while (self.weather == nil) {/*print("wait")*/}
        return self.weather;
    }
    static var weather: WeatherForecast?
    static let pi = 3.1415
    static func abc() -> Int {
        return 123;
    }
}
