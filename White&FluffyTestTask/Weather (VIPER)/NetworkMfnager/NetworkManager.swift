//
//  NetworkManager.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case invalidURL
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid url!!"
        case .emptyData:
            return "no data!!"
        }
    }
}

protocol NetworkManagerDescription: AnyObject {
    func currentWeather(for location: CLLocation, completion: @escaping (Result<Weather, Error>) -> Void)
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private let apiKey = "5944bbe4-ca46-49b1-bf4f-c1131c8a3b73"
    
    private init() {}
    
    func currentWeather(for location: CLLocation, completion: @escaping (Result<Weather, Error>) -> Void) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=en_US"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let currentWeather = try decoder.decode(Weather.self, from: data)
                completion(.success(currentWeather))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}


