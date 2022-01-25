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
    var secondMainClass: [List] = []
    
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
        
        dateOfToday.text = getDayForDate()
        dateOfToday.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        dailyCollectionView.backgroundColor = .none
        
        
    }
    
    private func getDayForDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
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
    //MARK:- WeatherManagerDelegate Protocol
    

extension ViewController: WeatherManagerDelegate {
    
    func data(weatherManager: WeatherManager, theWeather: TheWeather) {
        
        DispatchQueue.main.async {
            
            self.bigWeatherIcon.image = UIImage(systemName: theWeather.conditionName)
            self.tempreature.text = "\(theWeather.temperature)℃"
            self.maxAndMinTemp.text = "\(theWeather.maxTempreature)/\(theWeather.minTempreature)"
            self.cityName.text = "\(theWeather.city),\(theWeather.country)"
            self.smallWeatherIcon.image = UIImage(systemName: theWeather.conditionName)
            
        }
    }
    func passData(main: WeatherModel) {
        self.secondMainClass = main.list
        dailyCollectionView.reloadData()
        print(self.secondMainClass.count)
    }
    
    
}

//MARK:- UICollectionView     dataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondMainClass.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DailyWeatherCollectionViewCell
        let theData = secondMainClass[indexPath.row]        // data by indexPath
        
        let max = String(format: "%.0f",  theData.main.tempMax)
        let min = String(format: "%.0f",  theData.main.tempMin)
        
        cell.maxAndMin.text = "\(max)/\(min)"
        return cell
    }
}
//MARK:- UICollectionView Delegate & FlowLayout

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 150)
    }
    
}
