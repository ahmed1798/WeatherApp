//
//  WeatherNetwork.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

protocol WeatherNetworkProtocol {
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, Error>
}

// MARK: - WEATHER Network Service
class WeatherNetworkService: Session<WeatherWorker>, WeatherNetworkProtocol {
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, any Error> {
        let apiKey = "dbdc6dfb9d126a77a886e47804dbcd8b"
        return self.fetchRequest(target: .getWeather(cityName: cityName, apiKey: apiKey), WeatherResponse.self)
    }
}
