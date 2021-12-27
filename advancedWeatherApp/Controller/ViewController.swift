//
//  ViewController.swift
//  advancedWeatherApp
//
//  Created by Mahmoud on 12/27/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManger = CLLocationManager()
    var weatherManager = WeatherManager()
    var theWeatherinViewController: TheWeather?
    
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var maxAndMinTemp: UILabel!
    @IBOutlet weak var tempreature: UILabel!
    @IBOutlet weak var smallWeatherIcon: UIImageView!
    @IBOutlet weak var bigWeatherIcon: UIImageView!
    @IBOutlet weak var dateOfToday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        weatherManager.delegate = self
    }
    

}
extension ViewController: WeatherManagerDelegate {
    func data(weatherManager: WeatherManager, theWeather: TheWeather) {
        print("the weather Condition \(theWeather.conditionName)")  // success
        
    }
    
    
}

//MARK:- Location Manager

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("Longitude \(lon), Latitude \(lat)")
            weatherManager.getWeatherDate(lati: lat, long: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK:- CollectionView

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}

