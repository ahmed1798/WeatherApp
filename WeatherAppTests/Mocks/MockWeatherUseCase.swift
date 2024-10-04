//
//  MockWeatherUseCase.swift
//  WeatherAppTests
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine
@testable import WeatherApp

// MARK: - Enum Error Types
enum FetchWeatherErrorType {
    case invalidAPIKey
    case invalidURL
    case other(Error)
}

final class MockWeatherUseCase: WeatherUseCaseProtocol, Mockable {
    
    var shouldReturnError = false
    var errorType: FetchWeatherErrorType = .other(NSError(domain: "", code: -1, userInfo: nil))
    
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherResponse, Error> {
        if shouldReturnError {
            switch errorType {
            case .invalidAPIKey:
                let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid ApiKey"])
                return Fail(error: error).eraseToAnyPublisher()
            case .invalidURL:
                let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                return Fail(error: error).eraseToAnyPublisher()
            case .other(let error):
                return Fail(error: error).eraseToAnyPublisher()
            }
        } else {
            return loadJson(fileName: "WeatherResponse", type: WeatherResponse.self)
        }
    }
}
