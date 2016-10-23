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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var curHour = 0;
    var a = 0;
    var curXPosition = 0;
    var weather = WeatherHelper.getWeatherFor(city: "Saint Petersburg");
    var hourForecast = WeatherHelper.getHourWeatherFor(city: "Saint Petersburg")
    
    @IBOutlet weak var magicLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBAction func handleP(_ recognizer: UIPanGestureRecognizer) {
        a += 1;
        let p = recognizer.translation(in: self.view);
        if (Int(p.x) > 20) {
            let d :Double = min(1.0, ((Double(p.x) - 100.0) / 280.0));
            var tempHour = Int(d * 24);
            if (tempHour != curHour) {
                curHour = tempHour
                tempHour = (tempHour / 3);
                if (tempHour == 0) {updateWeather();} else {
                    currentTemperature.text = "\(hourForecast!.arrayForecast[tempHour - 1])º"
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
        hourForecast = WeatherHelper.getHourWeatherFor(city: "Saint Petersburg")
        
        if (weather != nil) {
            magicLabel.text = "Weather is update"
            currentTemperature.text = "\(Double(Int(weather!.currentTemperature!*10 - 2731.5))/10)º"
        }
       // let weather = WeatherHelper.getWeatherFor(city: "Moscow");
       // currentTemperature.text = "\( (weather?.currentTemperature)! - 273.15)º"
    }
}

