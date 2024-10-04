//
//  WeatherCache.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

class WeatherCache {
    
    static let instance = WeatherCache()
    private var weatherCache: [String: WeatherList] = [:]
    
    private init() {}
    
    //: MARK: - SAVE WEATHER To CACHED WEATHER DATA
    func saveWeather(_ weather: WeatherList, for cityName: String) {
        weatherCache[cityName] = weather
    }
    
    //: MARK: - GET WEATHER FROM CACHED WEATHER DATA
    func getWeather(for cityName: String) -> WeatherList? {
        return weatherCache[cityName]
    }
    
}
