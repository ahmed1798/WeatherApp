//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

//: MARK: - WEATHER VIEW MODEL
final class WeatherViewModel: ObservableObject {
    
    @Published var weatherList: WeatherList = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let useCases: WeatherUseCaseProtocol
    private var anyCancellable = Set<AnyCancellable>()
    
    init(useCases: WeatherUseCaseProtocol = WeatherUseCase()) {
        self.useCases = useCases
    }
    
    // MARK: - FETCHING WEATHER FROM API
    func fetchWeather(cityName: String) {
        isLoading = true
        useCases.fetchWeather(cityName: cityName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] weather in
                self?.weatherList = weather.list ?? []
            }.store(in: &anyCancellable)
    }
}
