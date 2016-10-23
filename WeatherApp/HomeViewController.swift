//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Иван Трофимов on 17.10.16.
//  Copyright © 2016 Иван Трофимов. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var weather = WeatherHelper();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var a = 0;
    var curXPosition = 0;
    @IBOutlet weak var magicLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBAction func handleP(_ recognizer: UIPanGestureRecognizer) {
        a += 1;
        let p = recognizer.translation(in: self.view);
        if (Int(p.x) > 100) {
            let d :Double = min(1.0, ((Double(p.x) - 100.0) / 280.0));
            magicLabel.text = "Timelaps \(Int(d * 24))";
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
        var weather = WeatherHelper.getWeatherFor(city: "Saint Petersburg");
        if (weather != nil) {
            magicLabel.text = "Weather is update"
            currentTemperature.text = "\(Double(Int(weather!.currentTemperature!*10 - 2731.5))/10)º"
        }
       // let weather = WeatherHelper.getWeatherFor(city: "Moscow");
       // currentTemperature.text = "\( (weather?.currentTemperature)! - 273.15)º"
    }
}

