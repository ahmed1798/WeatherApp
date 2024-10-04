//
//  WeatherRepoInterface.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

// MARK: - WEATHER REPOSITRY INTERFASCE
protocol WeatherRepoInterface {
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, Error>
}
