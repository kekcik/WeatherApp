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
    static func getForecastFor(city: String) -> [WeatherForecast]? {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/forecast"
        let params = ["q": city, "APPID": keys.openWeatherMapApiKye]
        var weather : [WeatherForecast];
        weather = []
        let queue = DispatchQueue(label: "com.cnoon.WeatherApp", qos: .utility, attributes: [.concurrent])
        request(weatherUrl, method: .get, parameters: params).responseJSON(queue: queue, completionHandler: { (DataResponse) in
            print(DataResponse)
            if (DataResponse.result.isFailure) {
                print("Detected Error")
            }
            if (DataResponse.result.isSuccess) {
                let weatherJson = JSON(data: DataResponse.data!)
                for i in 1...8 {
                    if let cityName = weatherJson["city"]["name"].string,
                        let currentTemperature = weatherJson["list"][i]["main"]["temp"].double,
                        let imageName = weatherJson["list"][i]["weather"][0]["main"].string,
                        let windDeg = weatherJson["list"][i]["wind"]["deg"].double,
                        let windSpeed = weatherJson["list"][i]["wind"]["speed"].double
                    {
                        var rainProbability: Int = 0
                        if let rain = weatherJson["list"][i]["clouds"]["all"].int {rainProbability = rain}
                        if let rain = weatherJson["list"][i]["rain"]["3h"].double    {rainProbability = Int(rain*100)}
                        if let rain = weatherJson["list"][i]["show"]["3h"].double    {rainProbability = Int(rain*100)}
                        print("\nParser: parsing is complete\n")
                        let weatherForTime = WeatherForecast.init(cityName: cityName, currentTemperature: currentTemperature, rainProbability: rainProbability, sunTime: nil, imageName: imageName, wind: (windDeg, windSpeed))
                        weather += [weatherForTime]
                        
                    } else {
                        print("\nError: parsing failed\n")
                    }

                }
                
            }
        })
        while (weather.count != 8) {print("wait")}
        return weather;
    }
    static func getWeatherFor(city: String) -> WeatherForecast? {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/weather"
        let params = ["q": city, "APPID": keys.openWeatherMapApiKye]
        var weather : WeatherForecast?;
        let queue = DispatchQueue(label: "com.cnoon.WeatherApp", qos: .utility, attributes: [.concurrent])
        request(weatherUrl, method: .get, parameters: params).responseJSON(queue: queue, completionHandler: { (DataResponse) in
            print(DataResponse)
            if (DataResponse.result.isFailure) {
                print("Detected Error")
            }
            if (DataResponse.result.isSuccess) {
                let weatherJson = JSON(data: DataResponse.data!)
                if let cityName = weatherJson["name"].string,
                    let currentTemperature = weatherJson["main"]["temp"].double,
                    let imageName = weatherJson["weather"][0]["main"].string,
                    let sunRise = weatherJson["sys"]["sunrise"].int,
                    let sunSet  = weatherJson["sys"]["sunset" ].int,
                    let windDeg = weatherJson["wind"]["deg"].double,
                    let windSpeed = weatherJson["wind"]["speed"].double
                {
                    var rainProbability: Int = 0
                    if let rain = weatherJson["clouds"]["all"].int {rainProbability = rain}
                    if let rain = weatherJson["rain"]["3h"].int    {rainProbability = rain}
                    if let rain = weatherJson["show"]["3h"].int    {rainProbability = rain}
                    print("\nParser: parsing is complete\n")
                    weather = WeatherForecast.init(cityName: cityName, currentTemperature: currentTemperature, rainProbability: rainProbability, sunTime: (sunRise, sunSet), imageName: imageName, wind: (windDeg, windSpeed))
                    
                } else {
                    print("\nError: parsing failed\n")
                }
            }
        })
        while (weather == nil) {/*print("wait")*/}
        return weather;
    }
    static func getHourWeatherFor(city: String) -> HourForecast? {
//        let weatherUrl = "http://api.openweathermap.org/data/2.5/forecast";
//        let params = ["q": city, "APPID": keys.openWeatherMapApiKye]
//        
        //return HourForecast.init(arrayForecast: [5.2,4.6,4.4,5,5.1,5.2,6.7,8])
        return nil;
    }
}
