//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 17.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
        
    }
    func setData(temperatur: Double?, sunTime: (Int, Int)?, rainProbability: Int?, city: String?, iconName: String?, wind: (Double, Double)?) {
        if (temperatur != nil) {
            currentTemperature.text = "\(Double(Int(temperatur!*10 - 2731.5))/10)º"
        }
        if (sunTime != nil) {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "HH:mm"
            let sunRise = NSDate(timeIntervalSince1970: TimeInterval(sunTime!.0))
            let sunSet = NSDate(timeIntervalSince1970: TimeInterval(sunTime!.1))
            let dateString = "\(dayTimePeriodFormatter.string(from: sunRise as Date)) | \(dayTimePeriodFormatter.string(from: sunSet as Date))"
            
            sunTimeLabel.text = dateString;
        }
        if (rainProbability != nil) {
            rainProbabilityLabel.text = "\(rainProbability!) %"
        }
        if (city != nil) {
            cityNameLAbel.text = city
        }
        if (iconName != nil) {
            var name = "Cloudy";
            if (iconName! == ("Clouds")) {name = "Cloudy"}
            if (iconName! == ("Rain")) {name = "Drizzle"}
            if (iconName! == ("Sun")) {name = "Sunny"}
            weatherIcon.image = UIImage.init(named: "\(name).png");
            weatherIcon.alpha = 0.6;
        }
        if (wind != nil) {
            let windSpeed = Int(wind!.1)
            var windDeg = ""
            if (wind!.0 >= 45 && wind!.0 < 135) {windDeg = "→"}
            if (wind!.0 >= 135 && wind!.0 < 225) {windDeg = "↓"}
            if (wind!.0 >= 225 && wind!.0 < 315) {windDeg = "←"}
            if (wind!.0 >= 315 || wind!.0 > 45) {windDeg = "↑"}
            windLabel.text = "\(windSpeed) m/s \(windDeg)"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var curHour = 0;
    var a = 0;
    var curXPosition = 0;
    var weather = WeatherHelper.getWeatherFor(city: "Saint Petersburg");
    var hourForecast = WeatherHelper.getForecastFor(city: "Saint Petersburg")
    
    @IBOutlet weak var sunTimeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainProbabilityLabel: UILabel!
    @IBOutlet weak var cityNameLAbel: UILabel!
    @IBOutlet weak var magicLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBAction func handleP(_ recognizer: UIPanGestureRecognizer) {
        a += 1;
        let p = recognizer.translation(in: self.view);
        if (Int(p.x) > 20) {
            let d :Double = min(1.0, ((Double(p.x) - 20.0) / 280.0));
            var tempHour = Int(d * 24);
            if (tempHour != curHour) {
                curHour = tempHour
                tempHour = (tempHour / 3);
                if (tempHour == 0) {
                    updateWeather();
                    magicLabel.text = "Magic Label"
                } else {
                    let a = hourForecast![tempHour - 1];
                    setData(temperatur: a.currentTemperature, sunTime: a.sunTime, rainProbability: a.rainProbability, city: a.cityName, iconName: a.imageName, wind: a.wind)
                    magicLabel.text = "Timelaps \(curHour)";
                }
            }
            print("chg \(a)")
        } else {
            print("smt \(a)")
        }
    }
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction.rawValue == 2) {
            a += 1;
            print("Swipe : \(a)) \(sender.direction)");
            magicLabel.text = "Magic Label";
        } else if (sender.direction.rawValue == 4){
            updateWeather();
        }
    }
    func updateWeather() {
        print("Start update");
        weather = WeatherHelper.getWeatherFor(city: "Saint Petersburg");
        hourForecast = WeatherHelper.getForecastFor(city: "Saint Petersburg")
        setData(temperatur: weather?.currentTemperature,
                sunTime: weather?.sunTime,
                rainProbability: weather?.rainProbability,
                city: weather?.cityName,
                iconName: weather?.imageName,
                wind: weather?.wind);
    }
}

