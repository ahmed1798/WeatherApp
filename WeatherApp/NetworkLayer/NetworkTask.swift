//
//  NetworkTask.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

//MARK: - METHOD TYPE
enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

//MARK: - REQUEST TASK TYPE
enum NetworkTask {
    case requestPlain // : REQUEST WITHOUT BODY OR PARAMETERS
    case getWithParameters(parameters: Encodable) // : REQUEST WITH BODY OR PARAMETERS
}

//MARK: - TARGET TYPE PROTOCOL
protocol TargetType {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var task: NetworkTask { get }
    var headers: [String: String]? { get }
}
