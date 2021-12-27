//
//  TheWeather.swift
//  advancedWeatherApp
//
//  Created by Mahmoud on 12/27/21.
//

import Foundation


class TheWeather {
    
    // Properties:
    let temp, maxTemp, minTemp: Double
    let id:Int
    
    // Initializer
    init(temp:Double, maxTemp:Double, minTemp:Double, id:Int) {
        self.temp = temp
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.id = id
    }
    
    // Computed Properties
    var temperature: String {
        String(format: "%.0f", temp)
    }
    
    var maxTempreature: String{
        String(format: "%.0f", maxTemp)
    }
    var minTempreature: String{
        String(format: "%.0f", minTemp)
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
