//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation

enum RequestError: Error, Identifiable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badRequest
    case apiError(String)

    var id: String {
        return UUID().uuidString
    }
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Request Error")
        case .badRequest:
            return NSLocalizedString("No matching location found.", comment: "Request Error")
        case .noResponse:
            return NSLocalizedString("No Response", comment: "Request Error")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "Request Error")
        case .unexpectedStatusCode:
            return NSLocalizedString("Unexpected Status Code.", comment: "Request Error")
        case .decode:
            return NSLocalizedString("Decoding Error", comment: "Request Error")
        case .unknown:
            return NSLocalizedString("Unknown Error", comment: "Request Error")
        case .apiError(let message):
            return NSLocalizedString("API Error", comment: message)
        }
    }
}



// MARK: - AllMessagesModel
struct APIErrorModel: Codable {
    let fault: FaultModel?
}

// MARK: - Fault
struct FaultModel: Codable {
    let faultstring: String?
    let detail: ErrorDetail?
}

// MARK: - Detail
struct ErrorDetail: Codable {
    let errorcode: String?
}
