//
//  WeatherFiveDaysViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

import Foundation
import Combine

//: MARK: - WEATHER FIVE DAYS VIEW MODEL
final class WeatherFiveDaysViewModel: ObservableObject {
    
    @Published var weather: WeatherList = []
}
