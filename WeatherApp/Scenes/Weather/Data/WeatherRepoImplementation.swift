//
//  WeatherRepoImplementation.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

// MARK: - WEATHER REPOSITRY Implementation
final class WeatherRepoImplementation: WeatherRepoInterface {
    
    let network: WeatherNetworkService
    init(network: WeatherNetworkService = WeatherNetworkService()) {
        self.network = network
    }
    
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, any Error> {
        return network.fetchWeather(cityName: cityName)
    }
}
