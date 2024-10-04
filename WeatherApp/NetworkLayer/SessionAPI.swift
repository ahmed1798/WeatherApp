//
//  SessionAPI.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit
import Combine

//MARK: - SESSION API THAT FETCHING REQUEST WITH COMBINE <FUTURE>
class Session<sessionTarget: TargetType> {
    func fetchRequest<T: Decodable>(target: sessionTarget, _ model: T.Type) -> AnyPublisher<T, Error> {
        
        return Future { promise in
            guard let url = URL(string: target.base + target.path) else {
                promise(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = target.method.rawValue
            request.allHTTPHeaderFields = target.headers
            request.httpBody = self.buildParameters(task: target.task.self)
            
            print("😳==URl==\(target.base + target.path) 💁🏻‍♀️==params==\(target.task)")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    // Map URLSession errors to your custom errors
                    promise(.failure(RequestError.apiError(error.localizedDescription)))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    return promise(.failure(RequestError.noResponse))
                }
                guard let data = data else { return }
                do {
                    switch response.statusCode {
                    case 200...299: //...Response Data
                        let decodedData = try JSONDecoder().decode(model.self, from: data)
                        debugPrint("Response Data = \(decodedData)")
                        promise(.success(decodedData))
                    case 422: //...Custom API Error Data
                        //...Decode API ERROR
                        let decodederror = try? JSONDecoder().decode(APIErrorModel.self, from: data)
                        let errorMessage = decodederror?.fault?.faultstring ?? ""
                        promise(.failure(RequestError.apiError(errorMessage)))
                    case 401: //...UnAuthorized
                        promise(.failure(RequestError.unauthorized))
                    case 400: //...Bad Request
                        promise(.failure(RequestError.badRequest))
                    case 404: //...Not Found
                        promise(.failure(RequestError.noResponse))
                    default:
                        promise(.failure(RequestError.unexpectedStatusCode))
                    }
                }
                catch let decodingError { //....Couldn't decode the response model
                    debugPrint(decodingError)
                    promise(.failure(RequestError.decode))
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    
    //MARK: - BUILD REQUEST BODY <PARAMETERS>
    func buildParameters(task: NetworkTask) -> Data? {
        switch task {
        case.requestPlain: //... NO PARAMETERS <GET>
            return nil
        case.getWithParameters (let encodedBody): //...PARAMETERS <POST>
            return try? JSONEncoder().encode(encodedBody)
        }
    }
}
