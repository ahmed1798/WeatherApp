//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

protocol WeatherUseCaseProtocol {
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, Error>
}

// MARK: - ARTICLE USE CASES
class WeatherUseCase: WeatherUseCaseProtocol {
    
    let repo: WeatherRepoInterface
    
    init(repo: WeatherRepoInterface = WeatherRepoImplementation()) {
        self.repo = repo
    }
    
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, any Error> {
        return repo.fetchWeather(cityName: cityName)
    }
}
