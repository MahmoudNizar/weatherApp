//
//  WeatherManager.swift
//  advancedWeatherApp
//
//  Created by Mahmoud on 12/27/21.
//
import Foundation
import Alamofire
protocol WeatherManagerDelegate {
    func data(weatherManager: WeatherManager, theWeather: TheWeather)
}
struct WeatherManager {

    var delegate: WeatherManagerDelegate?
    //Methods
    
    func getWeatherDate(lati:Double, long: Double) {
        let lat = String(lati)
        let lon = String(long)
        getData(lat: lat, lon: lon)
    }
    
    func getData(lat:String, lon:String){
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&cnt=6&appid=248c051620380d107a0dd53c88a86cd7"
        let request = AF.request(url)
        request.responseDecodable(of: WeatherModel.self) { (response) in
            guard let weather = response.value else {return}

            let temp = weather.list[0].main.temp
            let maxTemp = weather.list[0].main.tempMax
            let minTemp = weather.list[0].main.tempMin
            let conID = weather.list[0].weather[0].id
            let theWeather = TheWeather(temp: temp, maxTemp: maxTemp, minTemp:  minTemp,id: conID)
            delegate?.data(weatherManager: self, theWeather: theWeather)
            guard let er = response.error else {return}
            print(er)
        }
    }
    
    
    
}
