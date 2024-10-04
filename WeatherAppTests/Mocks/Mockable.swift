//
//  Mockable.swift
//  WeatherAppTests
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import Foundation
import Combine

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> AnyPublisher<T, any Error>
}

extension Mockable {
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    // MARK: - LOAD JSON FILE
    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> AnyPublisher<T, Error> {
        
        Future<T, any Error> { [weak self] promise in
            guard let self = self else { return }
            guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
                promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load json file"])))
                return
            }
            do {
                let data = try Data(contentsOf: path)
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return promise(.success(decodedObject))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

