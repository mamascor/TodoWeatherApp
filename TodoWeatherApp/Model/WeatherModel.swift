//
//  WeatherModel.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/12/22.
//

import Foundation


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    
    var temperatureString: String {
        return String(format: "%.0f", temperature )
    }
    
    var conditionName: String {
      
        
        switch conditionId {
        case 200...232:
            return "cloud-thunder"
        case 300...321:
            return "cloud-lightrain"
        case 500...531:
            return "light-rain"
        case 600...622:
            return "cloud-snow"
        case 701...781:
            return "cloud-wind"
        case 800:
            return "sun"
        case 801...804:
            return "cloud-thunder"
        default:
            return "cloudy"
        }
    }
}
