//
//  WeatherEntity.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

struct WeatherResponse: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [ListModel]?
    let city: CityModel?
}

typealias WeatherList = [ListModel]

// MARK: - City
struct CityModel: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct ListModel: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [WeatherModel]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility, pop: Int?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String?
}


// MARK: - Weather
struct WeatherModel: Codable {
    let id: Int?
    let main: String?
    let desc: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case desc = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
