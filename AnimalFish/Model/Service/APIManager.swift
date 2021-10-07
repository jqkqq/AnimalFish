//
//  APIManager.swift
//  AnimalSeaCreatures

import Foundation
import Alamofire
import Combine

enum APIError: Error {
    case responseError
    case parseError(Error)
}

class APIManager {
    
    static let shared = APIManager()
    
    func loadData(completion: @escaping([Value]) -> ()) {
        AF.request("http://acnhapi.com/v1/sea").response { (response) in
            if let data = response.data {
                do {
                    let seaFeaturies = try JSONDecoder().decode(Fish.self, from: data)
                    let featuries = seaFeaturies
                        .map({
                            $0.value
                        }).sorted(by: {
                            $0.id < $1.id
                        })
                    completion(featuries)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadSeaFeature() -> AnyPublisher<Fish, Error> {
        return
            URLSession.shared.dataTaskPublisher(for: URL(string: "http://acnhapi.com/v1/fish")!)
                .map(\.data)
                .mapError({ (error) -> Error in
                    APIError.responseError
                })
                .decode(type: Fish.self, decoder: JSONDecoder())
                .mapError({ (error) -> Error in
                    APIError.parseError(error)
                })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}
