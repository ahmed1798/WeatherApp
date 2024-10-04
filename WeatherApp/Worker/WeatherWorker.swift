//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

enum WeatherWorker {
    case getWeather(cityName: String, apiKey: String)
}

extension WeatherWorker: TargetType {
    var base: String {
        switch self {
        default:
            return "https://api.openweathermap.org/data/2.5/forecast"
        }
    }
    
    var path: String {
        switch self {
        case .getWeather(let cityName, let apiKey):
            return "?q=\(cityName)&appid=\(apiKey)&units=metric"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .getWeather:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getWeather:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
}

